;; dkellner-helm.el --- incremental search and narrowing
;;
;; See https://emacs-helm.github.io/helm .

(use-package helm
  ;; I want to use the more powerful "equivalents" most of the time, so I bind
  ;; them to the default Emacs shortcuts.
  :bind (("C-c g" . helm-grep-do-git-grep)
         ("C-h a" . helm-apropos)
         ("C-x C-f" . helm-find-files)
         ("C-x b" . helm-mini)
         ("M-x" . helm-M-x)
         ("M-y" . helm-show-kill-ring))
  :config
  (require 'helm-config)
  (helm-mode 1)
  (use-package helm-swoop
    :bind ("C-c s" . helm-swoop))
  (use-package helm-descbinds
    :config
    (helm-descbinds-mode))
  :diminish helm-mode)

(provide 'dkellner-helm)
