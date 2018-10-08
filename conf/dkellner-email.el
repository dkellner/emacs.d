;; dkellner-email.el --- mail config

;; TODO: find a better way
(add-to-list 'load-path "/nix/store/7j13zbx88i8vd4w0dq05yfkw5dp8rn91-notmuch-0.26.2/share/emacs/site-lisp")
(require 'notmuch)

(global-set-key (kbd "C-c m") #'notmuch)

(setq sendmail-program "msmtp"
      message-kill-buffer-on-exit t
      message-send-mail-function 'message-send-mail-with-sendmail
      message-sendmail-extra-arguments '("--read-envelope-from")
      message-sendmail-f-is-evil t
      notmuch-fcc-dirs '(("dominik.kellner@fotopuzzle.de"
                          . "puzzleandplay/.sent")
                         (".*" . "dkellner/.sent")))

;; Sometimes I still use mutt, e.g. for S/MIME-encrypted mails:
(add-to-list 'auto-mode-alist '("/tmp/mutt-" . mail-mode))
(add-hook 'mail-mode-hook #'turn-on-auto-fill)

(provide 'dkellner-email)
