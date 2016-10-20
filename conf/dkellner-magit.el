;; dkellner-magit.el --- frontend for git
;;
;; A very well written introduction can be found here:
;; https://www.masteringemacs.org/article/introduction-magit-emacs-mode-git

(use-package magit
  :config
  (defhydra dkellner/magit (:exit t)
    ("b" magit-blame "blame")
    ("d" magit-diff-buffer-file "diff-buffer-file")
    ("l" magit-log-buffer-file "log-buffer-file")
    ("s" magit-status "status"))
  (bind-key "C-c g" 'dkellner/magit/body))

(provide 'dkellner-magit)
