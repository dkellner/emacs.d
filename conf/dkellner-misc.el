;; dkellner-misc.el --- miscellaneous settings

(setq default-directory "~/")
(setq make-backup-files nil)
(setq-default require-final-newline t)
(setq-default indent-tabs-mode nil)

;; Remove trailing whitespace on save:
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Enable commands that are disabled by default:
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; Some keybindings for convenience:
(global-set-key (kbd "C-f") 'iy-go-to-char)
(global-set-key (kbd "C-b") 'iy-go-to-char-backward)
(global-set-key (kbd "C-s") 'isearch-forward-regexp)

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
