;; dkellner-company.el --- in-buffer completion
;;
;; See http://company-mode.github.io/ .

(use-package company
  :config
  (global-company-mode)
  (setq company-idle-delay t)
  (use-package company-quickhelp
    :config
    (company-quickhelp-mode 1)))

(provide 'dkellner-company)
