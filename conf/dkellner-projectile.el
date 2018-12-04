;; dkellner-projectile.el --- project management
;;
;; See http://projectile.readthedocs.io/en/latest/ .

(use-package projectile
  :config
  (define-key projectile-mode-map (kbd "C-p") #'projectile-command-map)
  (setq projectile-completion-system 'ivy
        projectile-switch-project-action #'projectile-vc)
  (projectile-mode 1)
  :diminish projectile-mode)

(use-package ibuffer-projectile
  :config
  (add-hook 'ibuffer-hook
            (lambda ()
              (ibuffer-projectile-set-filter-groups)
              (unless (eq ibuffer-sorting-mode 'alphabetic)
                (ibuffer-do-sort-by-alphabetic)))))

(provide 'dkellner-projectile)
