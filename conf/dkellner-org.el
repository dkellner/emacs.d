;; dkellner-org.el --- my life in plain text
;;
;; See http://orgmode.org/ .

;; Global keybindings to quickly view my agenda and capture thoughts.
(bind-key "C-c a" 'org-agenda)
(bind-key "C-c c" 'org-capture)

;; Basic configuration: set main org files for agenda/capturing and
;; TODO-keywords.
(setq org-directory "~/org/")
(setq org-agenda-files '("~/org/main.org"))
(setq org-refile-targets (quote (("main.org" :maxlevel . 2)
                                 ("someday.org" :level . 1))))
(setq org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "WAITING(w)" "|"
                                    "DONE(d)" "DEFERRED(f)")))
(setq org-startup-folded t)
(setq org-log-into-drawer t)
(setq org-agenda-todo-ignore-scheduled 'all)
(setq org-agenda-todo-ignore-deadlines 'all)
(setq org-agenda-tags-todo-honor-ignore-options t)
(setq org-agenda-restore-windows-after-quit t)

;; I mostly use the capture template for "Inbox" to put new ideas, todos etc.
;; in my `main.org' file for later processing (GTD-style).
(setq org-capture-templates
      '(("i" "Inbox" entry (file+headline "~/org/main.org" "Inbox")
         "* %?\n  Added: %U")
        ("j" "Journal" entry (file+datetree "~/org/journal.org")
         "* %?" :kill-buffer t)))

;; Enable habit tracking. For more information see
;; http://orgmode.org/org.html#Tracking-your-habits .
(require 'org-habit)

;; My custom agenda command is tailored to suit my workflow.
(setq org-agenda-custom-commands
      '(("c" "Weekly overview"
         ((agenda "" ((org-agenda-span 8)))
          (todo "TODO")))
        ("f" "Overview: fiedlbuehl"
         ((agenda "" ((org-agenda-span 'day)))
          (tags-todo "+fiedlbuehl-TODO=\"NEXT\"")
          (tags-todo "+laptop-TODO=\"NEXT\"")
          (tags-todo "+phone-TODO=\"NEXT\"")
          (tags-todo "+internet-TODO=\"NEXT\"")
          (tags-todo "+guitar-TODO=\"NEXT\"")
          (tags-todo "+errands-TODO=\"NEXT\"")))
        ("o" "Overview: office"
         ((agenda "" ((org-agenda-span 'day)))
          (tags-todo "+office-TODO=\"NEXT\"")
          (tags-todo "+laptop-TODO=\"NEXT\"")
          (tags-todo "+phone-TODO=\"NEXT\"")
          (tags-todo "+internet-TODO=\"NEXT\"")
          (tags-todo "+errands-TODO=\"NEXT\"")))
        ("." "Overview: elsewhere"
         ((agenda "" ((org-agenda-span 'day)))
          (tags-todo "+laptop-TODO=\"NEXT\"")
          (tags-todo "+phone-TODO=\"NEXT\"")
          (tags-todo "+internet-TODO=\"NEXT\"")
          (tags-todo "+errands-TODO=\"NEXT\"")))))

;; Enable more languages for Babel, especially useful for
;; "Literate Devops", see https://www.youtube.com/watch?v=dljNabciEGg .
(setq org-babel-load-languages '((emacs-lisp . t)
                                 (shell . t)))

;; Eye candy!
(setq org-hide-leading-stars t)
(use-package org-bullets
  :config
  (add-hook 'org-mode-hook 'org-bullets-mode))

;; I put this in an own function because I had problems when doing
;; `set-face-foreground' with Emacs running as a daemon. It did not apply the
;; setting for newly created frames.
(defun dkellner/beautify-org ()
  "Make org-mode look more beautiful."
  (dolist (face '(org-level-1 org-level-2 org-level-3))
    (set-face-background face nil)
    (set-face-attribute face nil :box nil :height 1.0))
  (set-face-foreground 'org-level-1 (face-foreground 'org-agenda-structure))
  (set-face-foreground 'org-level-2 (face-foreground 'default)))
(add-hook 'org-mode-hook #'dkellner/beautify-org)

(provide 'dkellner-org)
