;; dkellner-ui.el --- make emacs look even prettier

(use-package gruvbox-theme
  :config
  (load-theme 'gruvbox-dark-hard t))

(use-package bar-cursor
  :config
  (bar-cursor-mode 1)
  :diminish bar-cursor-mode)

(setq ring-bell-function 'ignore)
(setq inhibit-startup-message t)
(setq initial-scratch-message nil)

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

(provide 'dkellner-ui)
