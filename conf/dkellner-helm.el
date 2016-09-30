;; dkellner-helm.el --- incremental search and narrowing
;;
;; See https://emacs-helm.github.io/helm .

(mapc 'dkellner/install-package-if-missing '(helm
                                             helm-descbinds))
(require 'helm-config)
(helm-mode 1)

;; I want to use the more powerful "equivalents" most of the time, so I bind
;; them to the default Emacs shortcuts.
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "\C-x\C-f") 'helm-find-files)
(global-set-key (kbd "\C-xb") 'helm-mini)
(global-set-key (kbd "\C-ha") 'helm-apropos)

;; Wonder what helm-descbinds is?
;; Just press `C-h b` and prepare to be blown away.
(require 'helm-descbinds)
(helm-descbinds-mode)
