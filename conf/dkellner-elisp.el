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

;; Make the use of sharp-quote more convenient.
;; See http://endlessparentheses.com/get-in-the-habit-of-using-sharp-quote.html
(defun endless/sharp ()
  "Insert #' unless in a string or comment."
  (interactive)
  (call-interactively #'self-insert-command)
  (let ((ppss (syntax-ppss)))
    (unless (or (elt ppss 3)
                (elt ppss 4)
                (eq (char-after) ?'))
      (insert "'"))))
(bind-key "#" #'endless/sharp emacs-lisp-mode-map)

(use-package buttercup
  :bind (:map emacs-lisp-mode-map
              ("C-c C-t" . buttercup-run-at-point)))

(use-package rainbow-delimiters
  :hook (emacs-lisp-mode . rainbow-delimiters-mode))

(provide 'dkellner-elisp)
