;; dkellner-git.el --- magit and a little more
;;
;; A very well written introduction can be found here:
;; https://www.masteringemacs.org/article/introduction-magit-emacs-mode-git

(use-package magit
  :config
  (use-package git-timemachine)
  (defhydra dkellner/magit (:exit t)
    ("b" magit-blame "blame")
    ("d" magit-diff-buffer-file "diff-buffer-file")
    ("g" counsel-git-grep "grep")
    ("l" magit-log-buffer-file "log-buffer-file")
    ("s" magit-status "status")
    ("t" git-timemachine-toggle "timemachine"))
  (bind-key "C-c g" 'dkellner/magit/body)

  (setq magit-display-buffer-function
        #'magit-display-buffer-same-window-except-diff-v1))

(provide 'dkellner-git)
