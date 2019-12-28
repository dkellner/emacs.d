;; dkellner-ui.el --- make emacs look even prettier

(use-package gruvbox-theme
  :config
  (load-theme 'gruvbox-dark-hard t)
  (custom-theme-set-faces
   'gruvbox-dark-hard
   '(mode-line ((t (:foreground "#ebdbb2" :background "#2b3c44"))))
   '(mode-line-inactive ((t (:foreground "#3a3a3a" :background "#3a3a3a"))))
   '(mode-line-buffer-id ((t (:foreground "#ffffc8" :weight bold))))))

(use-package bar-cursor
  :config
  (bar-cursor-mode 1)
  :diminish bar-cursor-mode)

(setq ring-bell-function 'ignore)
(setq inhibit-startup-message t)
(setq initial-scratch-message nil)

(diminish 'auto-revert-mode)

(add-to-list 'default-frame-alist '(font . "Meslo LG M 13"))

(setq display-time-default-load-average nil
      display-time-24hr-format t)
(display-time-mode 0)

(setq window-divider-default-bottom-width 1
      window-divider-default-right-width 1)
(window-divider-mode)

(use-package all-the-icons)

(column-number-mode 1)
(setq mode-line-position
      '((line-number-mode ("%l" (column-number-mode ":%c"))))
      eol-mnemonic-unix nil)
(setq-default mode-line-format
              '("%e"
                mode-line-front-space

                ;; mode-line-mule-info
                (:eval (when current-input-method-title
                         (format "%s " current-input-method-title)))

                mode-line-client

                ;; mode-line-modified
                (:eval
                 (let* ((props (-concat `(:height ,(/ all-the-icons-scale-factor 1.6)
                                                  :v-adjust 0)
                                        (cond
                                         (buffer-read-only '(:face (:foreground "gray85")))
                                         ((buffer-modified-p) '(:face (:foreground "red"))))))
                        (icon (apply #'all-the-icons-icon-for-mode
                                     (-concat (list major-mode) props))))
                   (if (not (eq icon major-mode)) icon
                     (apply #'all-the-icons-icon-for-mode 'text-mode props))))

                ;; mode-line-remote
                ;; mode-line-frame-identification
                " "
                mode-line-buffer-identification
                " "
                mode-line-position
                " "
                mode-line-modes

                mode-line-misc-info
                mode-line-end-spaces))

(provide 'dkellner-ui)
