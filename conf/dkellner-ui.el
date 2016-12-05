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

(diminish 'auto-revert-mode)

(add-to-list 'default-frame-alist '(font . "Hack 12"))

;; Transparency
(add-to-list 'default-frame-alist '(alpha . 93))

(provide 'dkellner-ui)
