;; dkellner-eshell.el --- EShell configuration

(add-hook 'eshell-first-time-mode-hook #'dkellner/setup-eshell)

(defun dkellner/setup-eshell ()
  (add-to-list 'eshell-visual-commands "mysql")
  (add-to-list 'eshell-visual-commands "mplayer")
  (add-to-list 'eshell-visual-commands "mutt-dkellner")
  (add-to-list 'eshell-visual-commands "mutt-puzzleandplay"))

(provide 'dkellner-eshell)
