;; dkellner-projectile.el --- project management
;;
;; See http://projectile.readthedocs.io/en/latest/ .

(use-package projectile
  :config
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  :diminish projectile-mode)

(use-package counsel-projectile
  :config
  (setq counsel-projectile-switch-project-action
        #'counsel-projectile-switch-project-action-vc)
  (counsel-projectile-mode 1))

(use-package ibuffer-projectile
  :config
  (add-hook 'ibuffer-hook
            (lambda ()
              (ibuffer-projectile-set-filter-groups)
              (unless (eq ibuffer-sorting-mode 'alphabetic)
                (ibuffer-do-sort-by-alphabetic)))))

(provide 'dkellner-projectile)
