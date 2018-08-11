;; dkellner-email.el --- improve integration with mutt

(add-to-list 'auto-mode-alist '("/tmp/mutt-" . mail-mode))

(add-hook 'mail-mode-hook #'turn-on-auto-fill)

(provide 'dkellner-email)
