;; dkellner-eshell.el --- Eshell configuration

(add-hook 'eshell-first-time-mode-hook #'dkellner/setup-eshell)
(add-hook 'eshell-mode-hook #'dkellner/add-eshell-keys)
(add-hook 'eshell-mode-hook #'dkellner/eshell-hist-use-global-history)
(add-hook 'eshell-pre-command-hook #'eshell-save-some-history)

(setq eshell-history-size 10000
      eshell-hist-ignoredups t)

(defun dkellner/setup-eshell ()
  (setq eshell-visual-commands
        '("ssh" "mutt-puzzleandplay" "mutt-dkellner" "mplayer" "mysql" "vi"
          "screen" "top" "less" "more" "nix-shell"))
  (setq eshell-visual-subcommands
        '(("nixops" "ssh")
          ("nix" "repl")
          ("nix" "search")
          ("docker" "exec")
          ("stack" "repl")))
  (setq eshell-visual-options
        '(("gcloud" "connect" "ssh")
          ("kubectl" "exec")))
  (setq eshell-where-to-jump 'begin
        eshell-review-quick-commands nil
        eshell-smart-space-goes-to-end t
        eshell-prompt-regexp "^.* λ "
        eshell-prompt-function #'dkellner/eshell-prompt))

;; see https://gitlab.com/bennya/shrink-path.el
(defun dkellner/eshell-prompt ()
  (require 'shrink-path)
  (let ((base-dir (shrink-path-prompt default-directory)))
    (concat (propertize (car base-dir)
                        'face 'font-lock-comment-face)
            (propertize (cdr base-dir)
                        'face 'font-lock-constant-face)
            (propertize " λ" 'face 'eshell-prompt-face)
            ;; needed for the input text to not have prompt face
            (propertize " " 'face 'default))))

(defun dkellner/add-eshell-keys ()
  (define-key eshell-mode-map (kbd "C-c C-l") #'counsel-esh-history)
  (define-key eshell-mode-map (kbd "<up>") #'previous-line)
  (define-key eshell-mode-map (kbd "<down>") #'next-line))

(defun dkellner/new-eshell ()
  "Open a new Eshell.

The shell is opened in the directory associated with the current
buffer's file. The eshell buffer is renamed to match that
directory."
  (interactive)
  (let* ((dir (if (buffer-file-name)
                  (file-name-directory (buffer-file-name))
                default-directory))
         (name (abbreviate-file-name dir)))
    (eshell t)
    (rename-buffer (concat "*eshell:" name "*"))))

;;; Shared history, inspired by https://gitlab.com/ambrevar/dotfiles
(defvar dkellner/eshell-history-global-ring nil)

(defun dkellner/eshell-hist-use-global-history ()
  "Make Eshell history shared across different buffers."
  (unless dkellner/eshell-history-global-ring
    (when eshell-history-file-name
      (eshell-read-history nil t))
    (setq dkellner/eshell-history-global-ring
          (or eshell-history-ring (make-ring eshell-history-size))))
  (setq eshell-history-ring dkellner/eshell-history-global-ring))

(provide 'dkellner-eshell)
