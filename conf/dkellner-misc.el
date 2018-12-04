;; dkellner-misc.el --- miscellaneous settings

(setq default-directory "~/")
(setq make-backup-files nil)
(setq kill-ring-max 1000)
(setq-default require-final-newline t)
(setq-default indent-tabs-mode nil)
(setq-default fill-column 79)

(use-package recentf
  :demand t
  :config
  (setq recentf-max-saved-items 250)
  (add-to-list 'recentf-exclude no-littering-etc-directory)
  (add-to-list 'recentf-exclude no-littering-var-directory)
  (add-to-list 'recentf-exclude "^/\\(?:ssh\\|su\\|sudo\\)?:"))

(use-package dired
  :bind (("C-x C-d" . dired))
  :config
  (require 'dired-x)
  (setq dired-listing-switches "-ahl"
        dired-omit-files "^\\.")
  (add-hook 'dired-mode-hook
            (lambda () (dired-omit-mode))))

;; Remove trailing whitespace on save:
(add-hook 'before-save-hook #'delete-trailing-whitespace)

;; Highlight unnecessary whitespace:
(use-package whitespace
  :config
  (setq whitespace-style '(face empty tabs lines-tail trailing))
  (global-whitespace-mode t)
  :diminish global-whitespace-mode)

(use-package flycheck
  :config
  (global-flycheck-mode)
  :diminish flycheck-mode)

(use-package iedit)

(use-package expand-region
  :bind (("C-=" . er/expand-region)))

;; Enable commands that are disabled by default:
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)

;; Some keybindings for convenience:
(use-package iy-go-to-char
  :bind (("C-f" . iy-go-up-to-char)
         ("C-b" . iy-go-up-to-char-backward)))
(use-package avy
  :bind (("M-g g" . avy-goto-line)
         ("M-g M-g" . avy-goto-line)
         ("M-g M-s" . avy-goto-word-1)
         ("M-g M-r" . avy-copy-region)))

(use-package ibuffer
  :bind (("C-x C-b" . ibuffer))
  :config
  (setq ibuffer-formats '((mark modified read-only locked " "
                                (name 40 40 :left :elide)
                                " "
                                (size 9 -1 :right)
                                " "
                                (mode 16 16 :left :elide)
                                " " filename-and-process))))

;; Just kill the current buffer on pressing C-x k, don't ask which one to kill:
(bind-key "C-x k" #'dkellner/kill-current-buffer)

(defun dkellner/kill-current-buffer ()
  "Kill the current buffer."
  (interactive)
  (kill-buffer (current-buffer)))

;; Why would one ever want to suspend Emacs?! :)
(global-unset-key (kbd "C-z"))
(global-unset-key (kbd "C-x C-z"))

;; I use "C-c g" for `recompile' in my own mode for the Python debugger
;; (see dkellner-python.el). I don't want to care if it's actually
;; `compilation-mode` or `dkellner/pdb-mode` I'm seeing, so I bind it
;; for the former as well.
(defun dkellner/bind-recompile ()
  "Locally bind `recompile' to \"C-c g\""
  (local-set-key (kbd "C-c g") 'recompile))
(add-hook 'compilation-mode-hook 'dkellner/bind-recompile)

(use-package markdown-mode)
(use-package highlight-indentation)
(use-package yaml-mode
  :config
  (add-hook 'yaml-mode-hook #'highlight-indentation-current-column-mode))

(use-package which-key
  :config
  (which-key-mode)
  :diminish which-key-mode)

(setq term-ansi-default-program "/usr/bin/zsh")
(setq browse-url-browser-function #'browse-url-firefox)
(setq browse-url-firefox-arguments '("-p" "exwm"))

(global-set-key (kbd "C-x C-c") #'save-buffers-kill-emacs)

;; C-x k to kill all buffers, not C-x # for buffers opened by emacsclient.
;; see https://www.emacswiki.org/emacs/EmacsClient#toc36
(add-hook 'server-switch-hook
          (lambda ()
            (when (current-local-map)
              (use-local-map (copy-keymap (current-local-map))))
            (when server-buffer-clients
              (local-set-key (kbd "C-x k") 'server-edit))))

(setq shell-file-name "/bin/sh")

(use-package crux
  :bind (([remap move-beginning-of-line] . crux-move-beginning-of-line)
         ("C-c e" . crux-eval-and-replace)
         ("C-c o" . crux-open-with)
         ("C-c r" . crux-rename-file-and-buffer)
         ("C-c u" . crux-view-url)
         ("C-c D" . crux-delete-file-and-buffer)))

(provide 'dkellner-misc)
