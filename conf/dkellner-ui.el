;; dkellner-ui.el --- make emacs look even prettier

(use-package material-theme
  :config
  (load-theme 'material t)
  (custom-theme-set-faces
   'material
   '(mode-line ((t (:background "#0d47a1"))))
   '(mode-line-buffer-id ((t (:foreground "#fff59d"))))
   '(mode-line-inactive ((t (:background "#3a3a3a"))))
   '(org-mode-line-clock ((t (:background nil))))
   '(highlight-indentation-current-column-face ((t (:background "#424242"))))))

(use-package bar-cursor
  :config
  (bar-cursor-mode 1)
  :diminish bar-cursor-mode)

(setq visible-bell t)
(setq inhibit-startup-message t)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(show-paren-mode t)

(diminish 'auto-revert-mode)

(add-to-list 'default-frame-alist '(font . "Meslo LG M 13"))

;; Transparency
(add-to-list 'default-frame-alist '(alpha . 93))

;; Mode-Line, mostly inspired by this post:
;; http://www.holgerschurig.de/en/emacs-tayloring-the-built-in-mode-line/9
(column-number-mode 1)
(setq mode-line-position
      '((line-number-mode ("%l" (column-number-mode ":%c")))))
(setq-default mode-line-format
              '("%e"
                mode-line-front-space
                mode-line-mule-info
                mode-line-client
                mode-line-modified
                " "
                mode-line-buffer-identification
                " "
                mode-line-position
                (flycheck-mode flycheck-mode-line)
                " "
                mode-line-modes
                mode-line-misc-info
                mode-line-end-spaces))

(provide 'dkellner-ui)
