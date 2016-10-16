;; dkellner-elisp.el --- ELisp-specific configuration

(add-hook 'emacs-lisp-mode-hook 'eldoc-mode)

(use-package paredit
  :config
  (add-hook 'emacs-lisp-mode-hook 'paredit-mode)
  ;; I'm used to <C-left> and <C-right> for `left-word' and `right-word' so I
  ;; find it rather annoying that `paredit-mode' overwrites these with
  ;; `paredit-forward-barf-sexp' and `paredit-forward-slurp-sexp'.
  (define-key paredit-mode-map (kbd "<C-left>") nil)
  (define-key paredit-mode-map (kbd "<C-right>") nil)
  :diminish paredit-mode)

(use-package macrostep
  :bind (:map emacs-lisp-mode-map
              ("C-c e" . macrostep-expand)))

(provide 'dkellner-elisp)
