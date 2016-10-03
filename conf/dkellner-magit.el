;; dkellner-magit.el --- frontend for git
;;
;; A very well written introduction can be found here:
;; https://www.masteringemacs.org/article/introduction-magit-emacs-mode-git

(use-package magit
  :bind ("C-c m" . magit-status))

(provide 'dkellner-magit)
