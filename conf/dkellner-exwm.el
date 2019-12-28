;;; dkellner-exwm.el --- EXWM configuration

(defun dkellner/run (command)
  "Run COMMAND."
  (interactive (list (read-shell-command "$ ")))
  (start-process-shell-command command nil command))

;; from https://github.com/dakra/dmacs
(defun dkellner/exwm-bind-keys (&rest bindings)
  "Like exwm-input-set-key but syntax similar to bind-keys.
Define keybindings that work in exwm and non-exwm buffers.
Only works *before* exwm in initialized."
  (pcase-dolist (`(,key . ,fun) bindings)
    (add-to-list 'exwm-input-global-keys `(,(kbd key) . ,fun))))

(use-package exwm
  :demand t
  :bind (:map exwm-mode-map
         ("C-q" . #'exwm-input-send-next-key)
         ("s-SPC" . #'exwm-layout-toggle-fullscreen)
         ("s-F" . #'exwm-floating-toggle-fullscreen)
         ("M-y" . #'dkellner/exwm-counsel-yank-pop))
  :config

  ;; Workspaces

  (setq exwm-workspace-number 10
        exwm-workspace-show-all-buffers t
        exwm-layout-show-all-buffers t)

  (dotimes (i 10)
    (exwm-input-set-key (kbd (format "s-%d" i))
                        `(lambda ()
                           (interactive)
                           (exwm-workspace-switch-create ,i))))

  (require 'exwm-randr)
  (setq exwm-randr-workspace-output-plist '(1 "HDMI-1" 2 "HDMI-1"
                                            3 "HDMI-1" 4 "HDMI-1"
                                            5 "HDMI-1"))
  (exwm-randr-enable)

  ;; Global keybindings

  ;; TODO: swap-windows
  (dkellner/exwm-bind-keys
   '("s-b" . ivy-switch-buffer)
   '("s-q" . exwm-reset)
   '("s-x" . dkellner/run)
   '("s-<return>" . dkellner/new-eshell)
   '("s-f" . dkellner/browse/body)
   '("s-i" . exwm-input-toggle-keyboard)
   '("s-p" . (lambda () (interactive)
               (dkellner/run "~/dev/passman/passman submitform")))
   '("s-P" . (lambda () (interactive)
               (dkellner/run "~/dev/passman/passman onlypw submitform")))
   '("s-Z" . (lambda () (interactive) (dkellner/run "dm-tool lock")))
   '("s-n" . windmove-left)
   '("s-t" . windmove-right)
   '("s-g" . windmove-up)
   '("s-r" . windmove-down)
   '("s-." . split-window-right)
   '("s-," . split-window-below)
   '("s-m" . delete-other-windows)
   '("s-j" . delete-window)
   '("s-N" . (lambda () (interactive) (shrink-window-horizontally 2)))
   '("s-T" . (lambda () (interactive) (enlarge-window-horizontally 2)))
   '("s-Q" . dkellner/shutdown-or-reboot/body)
   '("<XF86MonBrightnessUp>" . (lambda () (interactive)
                                 (dkellner/run "~/hacks/backlightctl.sh inc")))
   '("<XF86MonBrightnessDown>" . (lambda () (interactive)
                                   (dkellner/run "~/hacks/backlightctl.sh dec")))
   '("<XF86AudioRaiseVolume>" . (lambda () (interactive)
                                  (dkellner/run "~/hacks/volumectl.sh inc")))
   '("<XF86AudioLowerVolume>" . (lambda () (interactive)
                                  (dkellner/run "~/hacks/volumectl.sh dec")))
   '("<XF86AudioMute>" . (lambda () (interactive)
                           (dkellner/run "~/hacks/volumectl.sh toggle")))
   '("<XF86AudioMicMute>" . (lambda () (interactive)
                              (dkellner/run "~/hacks/volumectl.sh mic_toggle"))))

  ;; Input simulation

  (add-to-list 'exwm-input-prefix-keys ?\C-p) ; Projectile

  (setq exwm-input-simulation-keys
        '(([?\M-<] . [home])
          ([?\M->] . [end])
          ([?\C-k] . [S-end ?\C-x])
          ([?\C-w] . [?\C-x])
          ([?\C-s] . [?\C-f])
          ([?\C-g] . [esc])
          ([?\C-x ?\C-s] . [?\C-s])
          ([?\M-w] . [?\C-c])
          ([?\C-y] . [?\C-v])))

  ;; Hooks

  (add-hook 'exwm-update-class-hook #'dkellner/exwm-update-class-hook)
  (add-hook 'exwm-update-title-hook #'dkellner/exwm-update-title-hook)

  ;; Misc

  (require 'exwm-systemtray)
  (exwm-systemtray-enable)

  (use-package exwm-edit)

  ;; see https://github.com/ch11ng/exwm/wiki#an-issue-with-ediff-mode-in-magit
  (setq ediff-window-setup-function 'ediff-setup-windows-plain))

;; from https://github.com/dakra/dmacs
(defun dkellner/exwm-counsel-yank-pop ()
  "Same as `counsel-yank-pop' and paste into exwm buffer."
  (interactive)
  (let ((inhibit-read-only t)
        ;; Make sure we send selected yank-pop candidate to
        ;; clipboard:
        (yank-pop-change-selection t))
    (call-interactively #'counsel-yank-pop))
  (when (derived-mode-p 'exwm-mode)
    (exwm-input--set-focus (exwm--buffer->id (window-buffer (selected-window))))
    (exwm-input--fake-key ?\C-v)))

(defun dkellner/exwm-update-class-hook ()
  (unless (dkellner/exwm-use-title-for-buffer-name)
    (exwm-workspace-rename-buffer exwm-class-name)))

(defun dkellner/exwm-update-title-hook ()
  (when (or (not exwm-instance-name)
            (dkellner/exwm-use-title-for-buffer-name))
    (exwm-workspace-rename-buffer exwm-title)))

(defun dkellner/exwm-use-title-for-buffer-name ()
  (or (string-prefix-p "sun-awt-X11-" exwm-instance-name)
      (string= "gimp" exwm-instance-name)
      (string= "Navigator" exwm-instance-name)
      (string= "gajim" exwm-instance-name)))

(defhydra dkellner/shutdown-or-reboot (:exit t)
  "Shutdown/reboot?"
  ("s" #'dkellner/shutdown "shutdown")
  ("r" #'dkellner/reboot "reboot"))

(defun dkellner/shutdown ()
  "Clock out, save buffers and shutdown."
  (interactive)
  (dkellner/prepare-exit)
  (dkellner/run "shutdown -h now"))

(defun dkellner/reboot ()
  "Save buffers and reboot."
  (interactive)
  (dkellner/prepare-exit)
  (dkellner/run "shutdown -r now"))

(defun dkellner/prepare-exit ()
  (when (org-clock-is-active)
    (org-clock-out))
  (save-some-buffers)
  (recentf-save-list))

(defhydra dkellner/browse (:exit t)
  "Browse"
  ("o" #'browse-url "url")
  ("b" #'dkellner/open-browser-bookmark "bookmark")
  ("d" (dkellner/search-online "https://duckduckgo.com/?q=%s") "duckduckgo")
  ("w" (dkellner/search-online
        "https://www.wikipedia.org/search-redirect.php?language=en&go=Go&search=%s")
   "wikipedia")
  ("t" (dkellner/lookup-dictionary/body) "dictionary"))

(defhydra dkellner/lookup-dictionary (:exit t)
  "Lookup dictionary"
  ("e" (dkellner/search-online "https://dict.cc/%s") "DE <-> EN")
  ("v" (dkellner/search-online
        "http://tratu.coviet.vn/tu-dien-lac-viet.aspx?learn=hoc-tieng-anh&t=A-V&k=%s")
   "EN -> VN"))

(defun dkellner/search-online (search-engine-url)
  (let ((query (read-string "Query: ")))
    (browse-url (format search-engine-url query))))

(use-package gpastel
  :hook (exwm-init . gpastel-start-listening))

(defun dkellner/autostart ()
  "Run some applications on startup."
  (start-process-shell-command "cbatticon" nil "cbatticon")
  (start-process-shell-command "nm-applet" nil "nm-applet")
  (start-process-shell-command "nextcloud" nil "nextcloud"))
(add-hook 'exwm-init-hook #'dkellner/autostart)

(provide 'dkellner-exwm)
