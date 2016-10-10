;; dkellner-org.el --- my life in plain text
;;
;; See http://orgmode.org/ .

(bind-key "C-c a" 'org-agenda)
(bind-key "C-c c" 'org-capture)

(setq org-directory "~/org/")
(setq org-agenda-files '("~/org/main.org"))
(setq org-refile-targets (quote (("main.org" :maxlevel . 2)
                                 ("someday.org" :level . 1))))

(setq org-startup-folded t)
(setq org-hide-leading-stars t)

(setq org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "WAITING(w)" "|"
                                    "DONE(d)" "DEFERRED(f)")))

(setq org-tag-alist '((:startgroup . nil)
                      ("fiedlbuehl" . ?f)
                      ("office" . ?o)
                      ("errands" . ?e)
                      (:endgroup . nil)
                      ("laptop" . ?l)
                      ("guitar" . ?g)
                      ("phone" . ?p)
                      ("internet" . ?i)
                      ))

(setq org-agenda-custom-commands
      '(("c" "Agenda and TODOs by context"
         ((agenda "" ((org-agenda-ndays 8)))
          (tags-todo "laptop")
          (tags-todo "internet")
          (tags-todo "phone")
          (tags-todo "errands")
          (tags-todo "fiedlbuehl")
          (tags-todo "office")
          (todo "TODO")
          ))
        ("d" "Daily action list"
         ((agenda "" ((org-agenda-ndays 1)
                      (org-agenda-sorting-strategy
                       (quote ((agenda time-up priority-down tag-up))))
                      (org-deadline-warning-days 0)))
          ))
        ))

(setq org-capture-templates
      '(("i" "Inbox" entry (file+headline "~/org/main.org" "Inbox")
         "* %?\n  Added: %U")
        ("j" "Journal" entry (file "~/org/journal.org")
         "* %?\n  Added: %U")
        ))

(provide 'dkellner-org)
