;; dkellner-misc.el --- miscellaneous settings

(setq default-directory "~/")
(setq make-backup-files nil)
(setq-default require-final-newline t)
(setq-default indent-tabs-mode nil)

;; Run in server mode. This is needed for running `emacsclient` and I mostly
;; use it for integration with mutt.
(server-mode 1)

;; Remove trailing whitespace on save:
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Enable commands that are disabled by default:
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; Some keybindings for convenience:
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(use-package iy-go-to-char
  :bind (("C-f" . iy-go-to-char)
         ("C-b" . iy-go-to-char-backward)))

;; Just kill the current buffer on pressing C-x k, don't ask which one to kill:
(defun dkellner/kill-buffer ()
  "Kill the current buffer."
  (interactive)
  (kill-buffer))
(global-set-key (kbd "C-x k") 'dkellner/kill-buffer)

;; I use "C-c g" for `recompile' in my own mode for the Python debugger
;; (see dkellner-python.el). I don't want to care if it's actually
;; `compilation-mode` or `dkellner/pdb-mode` I'm seeing, so I bind it
;; for the former as well.
(defun dkellner/bind-recompile ()
  "Locally bind `recompile' to \"C-c g\""
  (local-set-key (kbd "C-c g") 'recompile))
(add-hook 'compilation-mode-hook 'dkellner/bind-recompile)

;; Make C-a and <home> toggle between the first non-whitespace character and
;; the actual beginning of the line.
;; See http://emacsredux.com/blog/2013/05/22/smarter-navigation-to-the-beginning-of-a-line/
(defun dkellner/smarter-move-beginning-of-line (arg)
  "Move point back to indentation of beginning of line.

Move point to the first non-whitespace character on this line.
If point is already there, move to the beginning of the line.
Effectively toggle between the first non-whitespace character and
the beginning of the line.

If ARG is not nil or 1, move forward ARG - 1 lines first.  If
point reaches the beginning or end of the buffer, stop there."
  (interactive "^p")
  (setq arg (or arg 1))

  ;; Move lines first
  (when (/= arg 1)
    (let ((line-move-visual nil))
      (forward-line (1- arg))))

  (let ((orig-point (point)))
    (back-to-indentation)
    (when (= orig-point (point))
      (move-beginning-of-line 1))))
(global-set-key [remap move-beginning-of-line]
                'dkellner/smarter-move-beginning-of-line)

(provide 'dkellner-misc)
