;; dkellner-projectile.el --- project management
;;
;; See http://projectile.readthedocs.io/en/latest/ .

(use-package projectile
  :config
  (projectile-global-mode)
  (setq projectile-completion-system 'ivy)
  :diminish projectile-mode)

(use-package ibuffer-projectile
  :config
  (add-hook 'ibuffer-hook
            (lambda ()
              (ibuffer-projectile-set-filter-groups)
              (unless (eq ibuffer-sorting-mode 'alphabetic)
                (ibuffer-do-sort-by-alphabetic)))))

(provide 'dkellner-projectile)
