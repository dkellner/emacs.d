;; dkellner-ace-window.el -- better window navigation
;;
;; ace-window is a nice way to navigate windows, see
;; https://github.com/abo-abo/ace-window .

(use-package ace-window
  :bind ("C-n" . ace-window)
  :config
  (setq aw-keys '(?i ?a ?e ?r ?t))
  (setq aw-dispatch-always t)
  (setq aw-background nil)
  (add-to-list 'aw-dispatch-alist
               '(?h aw-split-window-horz " Ace - Split Horz Window")))

(provide 'dkellner-ace-window)
