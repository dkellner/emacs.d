;; dkellner-misc.el --- miscellaneous settings

(setq default-directory "~/")
(setq make-backup-files nil)
(setq-default require-final-newline t)
(setq-default indent-tabs-mode nil)

;; Remove trailing whitespace on save:
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Highlight unnecessary whitespace
(use-package whitespace
  :config
  (setq whitespace-style '(face empty tabs lines-tail trailing))
  (global-whitespace-mode t)
  :diminish global-whitespace-mode)

(use-package flycheck
  :config
  (global-flycheck-mode))

;; Enable commands that are disabled by default:
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; Some keybindings for convenience:
(bind-key "C-x C-b" 'ibuffer)
(use-package iy-go-to-char
  :bind (("C-f" . iy-go-to-char)
         ("C-b" . iy-go-to-char-backward)))
(use-package avy
  :bind ("M-g g" . avy-goto-line))

;; Just kill the current buffer on pressing C-x k, don't ask which one to kill:
(bind-key "C-x k" 'kill-this-buffer)

;; Why would one ever want to suspend Emacs?! :)
(global-unset-key (kbd "C-z"))
(global-unset-key (kbd "C-x C-z"))

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
(bind-key "<home>" 'dkellner/smarter-move-beginning-of-line)

(use-package markdown-mode)
(use-package yaml-mode)

;; Constantly improve myself by using better suited commands instead of
;; repeating "simple" ones.
;; see https://bitbucket.org/shackra/dwight-k.-schrute/
(use-package schrute
  :config
  (setq schrute-shortcuts-commands
        '((iy-go-to-char . (right-char))
          (iy-go-to-char-backward . (left-char))
          (avy-goto-line . (next-line))
          (avy-goto-line . (previous-line))))
  (schrute-mode)
  :diminish schrute-mode)

(setq term-ansi-default-program "/usr/bin/zsh")
(setq browse-url-browser-function #'browse-url-firefox)

(provide 'dkellner-misc)
