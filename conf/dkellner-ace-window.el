;; dkellner-ace-window.el -- better window navigation
;;
;; ace-window is a nice way to navigate windows, see
;; https://github.com/abo-abo/ace-window .

(dkellner/install-package-if-missing 'ace-window)

(global-set-key (kbd "C-n") 'ace-window)

(setq aw-keys '(?i ?a ?e ?r ?t))
(setq aw-dispatch-always t)
(setq aw-background nil)

(eval-after-load "ace-window"
  '(progn
     (add-to-list 'aw-dispatch-alist
                  '(?h aw-split-window-horz " Ace - Split Horz Window"))))
