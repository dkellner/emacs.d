;; dkellner-elfeed.el --- Read news feeds

(use-package elfeed
  :bind ("C-c n" . elfeed)
  :config
  (setq-default elfeed-search-filter "@1-week-ago +unread ")
  (use-package elfeed-org
    :config
    (elfeed-org)
    (setq rmh-elfeed-org-files (list "~/org/elfeed.org")))
  (use-package elfeed-goodies
    :config
    (elfeed-goodies/setup)
    (setq elfeed-goodies/entry-pane-position 'bottom)))

(provide 'dkellner-elfeed)
