;; dkellner-projectile.el --- project management
;;
;; See http://projectile.readthedocs.io/en/latest/ .

(use-package projectile
  :config
  (projectile-global-mode)
  (setq projectile-completion-system 'ivy)
  :diminish projectile-mode)

(provide 'dkellner-projectile)
