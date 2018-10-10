;; dkellner-ui.el --- make emacs look even prettier

(use-package gruvbox-theme
  :config
  (load-theme 'gruvbox-dark-hard t)
  (custom-theme-set-faces
   'gruvbox-dark-hard
   '(spaceline-unmodified ((t (:background "#b8bb26" :foreground "#222222"))))
   '(spaceline-modified ((t (:background "#fb4933" :foreground "#222222"))))
   '(spaceline-read-only ((t (:background "#d3869b" :foreground "#222222"))))))

(use-package bar-cursor
  :config
  (bar-cursor-mode 1)
  :diminish bar-cursor-mode)

(setq ring-bell-function 'ignore)
(setq inhibit-startup-message t)
(setq initial-scratch-message nil)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(show-paren-mode t)

(diminish 'auto-revert-mode)

(add-to-list 'default-frame-alist '(font . "Meslo LG M 13"))

(setq battery-mode-line-format "%p ")
(display-battery-mode 1)

(setq display-time-default-load-average nil
      display-time-24hr-format t)
(display-time-mode 0)

(setq window-divider-default-bottom-width 1
      window-divider-default-right-width 1)
(window-divider-mode)

(use-package dimmer
  :config
  (setq dimmer-fraction 0.15)
  (dimmer-mode))

(use-package spaceline
  :config
  (spaceline-emacs-theme)

  (setq spaceline-buffer-size-p nil
        spaceline-buffer-modified-p nil
        spaceline-buffer-encoding-p nil
        spaceline-buffer-position-p nil
        spaceline-buffer-encoding-abbrev-p nil
        spaceline-hud-p nil
        spaceline-version-control-p nil
        spaceline-highlight-face-func #'spaceline-highlight-face-modified)

  (spaceline-define-segment workspace-number
    (propertize (int-to-string exwm-workspace-current-index) 'face 'bold))

  (spaceline-compile))

(provide 'dkellner-ui)
