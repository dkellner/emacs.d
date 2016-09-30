;; dkellner-projectile.el --- project management
;;
;; The main use case for me is to navigate files within a project. This is done
;; by pressing `C-c p f`.
;;
;; See http://projectile.readthedocs.io/en/latest/ .

(mapc 'dkellner/install-package-if-missing '(projectile
                                             helm-projectile))
(projectile-global-mode)
(helm-projectile-on)
