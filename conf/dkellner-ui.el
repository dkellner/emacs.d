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

(use-package whitespace
  :config
  (setq whitespace-style '(face empty tabs lines-tail trailing))
  (global-whitespace-mode t)
  :diminish global-whitespace-mode)

(set-face-font 'default "Inconsolata 12")

(provide 'dkellner-ui)
