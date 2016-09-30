;; dkellner-ui.el --- make emacs look even prettier

(dkellner/install-package-if-missing 'material-theme)
(load-theme 'material t)

(dkellner/install-package-if-missing 'powerline)
(powerline-default-theme)

(setq visible-bell t)

(setq inhibit-startup-message t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(show-paren-mode t)

(require 'whitespace)
(setq whitespace-style '(face empty tabs lines-tail trailing))
(global-whitespace-mode t)

(set-face-font 'default "Inconsolata 12")
