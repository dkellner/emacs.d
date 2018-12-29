;; dkellner-company.el --- in-buffer completion
;;
;; See http://company-mode.github.io/ .

(use-package company
  :defer t
  :hook (after-init . global-company-mode)
  :config
  (setq company-idle-delay 0.5)
  (setq company-dabbrev-downcase nil
        company-dabbrev-ignore-case nil))

(provide 'dkellner-company)
