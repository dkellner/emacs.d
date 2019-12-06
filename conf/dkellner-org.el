;; dkellner-org.el --- my life in plain text
;;
;; See http://orgmode.org/ .

;; Global keybindings to quickly view my agenda and capture thoughts.
(bind-key "C-c a" #'org-agenda)
(bind-key "C-c c" #'org-capture)
(bind-key "C-c l" #'org-store-link)

;; Basic configuration: set main org files for agenda/capturing and
;; TODO-keywords.
(setq org-directory "~/org/")
(setq org-agenda-files '("~/org/main.org" "~/org/tickler.org"))
(setq org-refile-targets '(("main.org" :maxlevel . 2)
                           ("pap.org" :maxlevel . 1)
                           ("tickler.org" :maxlevel . 1)
                           ("bookmarks.org" :maxlevel . 1)
                           ("someday.org" :level . 1)))
(setq org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "WAITING(w)" "|"
                                    "DONE(d)")))

;; This list contains tags I want to use in almost any file as they are tied to
;; actionable items (e.g. GTD contexts).
(setq org-tag-alist `((:startgroup)
                      ("@laptop" . ,(string-to-char "l"))
                      ("@phone" . ,(string-to-char "p"))
                      ("@home" . ,(string-to-char "h"))
                      ("@fiedlbuehl" . ,(string-to-char "f"))
                      ("@errands" . ,(string-to-char "e"))
                      (:endgroup)))

(setq org-startup-folded t)
(setq org-log-into-drawer t)
(setq org-agenda-todo-ignore-scheduled 'all)
(setq org-agenda-todo-ignore-deadlines 'all)
(setq org-agenda-tags-todo-honor-ignore-options t)
(setq org-agenda-restore-windows-after-quit t)
(setq org-time-clocksum-format "%d:%02d")
(setq org-enforce-todo-dependencies t)
(setq org-columns-default-format
      "%40ITEM(Task) %3Priority(Pr.) %16Effort(Estimated Effort){:} %CLOCKSUM{:}")
(setq org-export-with-sub-superscripts nil)
(setq org-export-allow-bind-keywords t)
(setq org-default-priority ?C)
(setq org-use-speed-commands t)

;; I mostly use the capture template for "Inbox" to put new ideas, todos etc.
;; in my `main.org' file for later processing (GTD-style).
(setq org-capture-templates
      '(("i" "Inbox" entry (file "~/org/inbox.org")
         "* %?")
        ("I" "Inbox (with link)" entry (file "~/org/inbox.org")
         "* %?\n  %a")
        ("j" "Journal" entry (file+datetree "~/org/journal.org")
         "* %?" :kill-buffer t)))

;; Enable habit tracking. For more information see
;; http://orgmode.org/org.html#Tracking-your-habits .
(require 'org-habit)

(require 'org-drill)
(require 'org-notmuch)

(setq org-agenda-custom-commands
      '(("h" "Home"
         ((agenda "" ((org-agenda-span 'day)))
          (todo "TODO"
                ((org-agenda-sorting-strategy
                  '(priority-down tag-up))))))
        ("w" "Work"
         ((agenda "" ((org-agenda-span 'day)))
          (todo "TODO"
                ((org-agenda-sorting-strategy
                  '(priority-down tag-up)))))
         ((org-agenda-files (append org-agenda-files '("~/org/pap.org")))))))

;; Enable more languages for Babel, especially useful for
;; "Literate Devops", see https://www.youtube.com/watch?v=dljNabciEGg .
(org-babel-do-load-languages 'org-babel-load-languages '((emacs-lisp . t)
                                                         (python . t)
                                                         (shell . t)
                                                         (dot . t)))

;; Eye candy!
(setq org-hide-leading-stars t)

;; Simple presentations inside Emacs.
(use-package org-tree-slide)

(add-hook 'org-mode-hook (lambda () (auto-fill-mode 1)))

(use-package org-pomodoro
  :bind ("C-c P" . org-pomodoro)
  :config
  (setq org-pomodoro-format "● %s"
        org-pomodoro-short-break-format "◔ %s"
        org-pomodoro-long-break-format "◕ %s"
        org-pomodoro-audio-player "aplay"))

(use-package org-super-agenda
  :config
  (setq org-super-agenda-groups
        '(
          (:name "work"
                 :tag "work")
          (:name "@laptop"
                 :tag "@laptop")
          (:name "@phone"
                 :tag "@phone")
          (:name "@home"
                 :tag "@home")
          (:name "@errands"
                 :tag "@errands")
          (:name "@fiedlbuehl"
                 :tag "@fiedlbuehl")))
  (org-super-agenda-mode 1))

;; Make org-drill work with org-mode 9.2, see:
;; https://bitbucket.org/eeeickythump/org-drill/issues/62/org-drill-doesnt-work-with-org-mode-92
(defun org-drill-hide-subheadings-if (test)
  "TEST is a function taking no arguments. TEST will be called for each
of the immediate subheadings of the current drill item, with the point
on the relevant subheading. TEST should return nil if the subheading is
to be revealed, non-nil if it is to be hidden.
Returns a list containing the position of each immediate subheading of
the current topic."
  (let ((drill-entry-level (org-current-level))
        (drill-sections nil))
    (org-show-subtree)
    (save-excursion
      (org-map-entries
       (lambda ()
         (when (and (not (org-invisible-p))
                    (> (org-current-level) drill-entry-level))
           (when (or (/= (org-current-level) (1+ drill-entry-level))
                        (funcall test))
             (hide-subtree))
           (push (point) drill-sections)))
       nil 'tree))
    (reverse drill-sections)))

(provide 'dkellner-org)
