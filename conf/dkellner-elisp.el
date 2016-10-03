;; dkellner-elisp.el --- ELisp-specific configuration

(use-package macrostep
  :bind (:map emacs-lisp-mode-map
              ("C-c e" . macrostep-expand)))

(provide 'dkellner-elisp)
