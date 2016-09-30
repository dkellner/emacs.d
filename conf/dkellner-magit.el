;; dkellner-magit.el --- frontend for git
;;
;; A very well written introduction can be found here:
;; https://www.masteringemacs.org/article/introduction-magit-emacs-mode-git

(dkellner/install-package-if-missing 'magit)

(global-set-key (kbd "C-c m") 'magit-status)
