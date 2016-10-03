;; dkellner-helm.el --- incremental search and narrowing
;;
;; See https://emacs-helm.github.io/helm .

(use-package helm
  ;; I want to use the more powerful "equivalents" most of the time, so I bind
  ;; them to the default Emacs shortcuts.
  :bind (("M-x" . helm-M-x)
         ("\C-x\C-f" . helm-find-files)
         ("\C-xb" . helm-mini)
         ("\C-ha" . helm-apropos))
  :config
  (require 'helm-config)
  (helm-mode 1)
  (use-package helm-descbinds
    :config
    (helm-descbinds-mode))
  :diminish helm-mode)

(provide 'dkellner-helm)
