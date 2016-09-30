;; dkellner-company.el --- in-buffer completion
;;
;; See http://company-mode.github.io/ .

(mapc 'dkellner/install-package-if-missing '(company
                                             company-quickhelp))
(add-hook 'after-init-hook 'global-company-mode)
(setq company-idle-delay t)
(company-quickhelp-mode 1)
