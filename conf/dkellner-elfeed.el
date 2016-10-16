;; dkellner-elfeed.el --- Read news feeds

(use-package elfeed
  :bind ("C-c n" . elfeed)
  :config
  (use-package elfeed-org
    :config
    (elfeed-org)
    (setq rmh-elfeed-org-files (list "~/org/elfeed.org"))))

(provide 'dkellner-elfeed)
