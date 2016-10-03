;; dkellner-projectile.el --- project management
;;
;; The main use case for me is to navigate files within a project. This is done
;; by pressing `C-c p f`.
;;
;; See http://projectile.readthedocs.io/en/latest/ .

(use-package projectile
  :config
  (projectile-global-mode))

(use-package helm-projectile
  :config
  (helm-projectile-on))

(provide 'dkellner-projectile)
