;; dkellner-ui.el --- make emacs look even prettier

(use-package material-theme
  :config
  (load-theme 'material t))

(use-package powerline
  :config
  (powerline-default-theme))

(setq visible-bell t)
(setq inhibit-startup-message t)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(show-paren-mode t)

(set-face-font 'default "Hack 12")

;; Transparency
(set-frame-parameter (selected-frame) 'alpha 93)

(provide 'dkellner-ui)
