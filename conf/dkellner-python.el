;; dkellner-python.el --- Python-specific configuration

;; The following is not mature and well-tested yet, but first results are
;; pleasing. When running a test we try to detect "(Pdb)" in the process'
;; output - if we do, we change the mode to `dkellner/pdb-mode' which enables
;; us to interact with the debugger.
;;
;; TODO: Move point to the end of the buffer (that is, after "(Pdb) ")

(define-derived-mode dkellner/pdb-mode comint-mode "Pdb"
  "Major mode for interacting with the Python debugger `Pdb'."
  (setq buffer-read-only nil)
  (local-set-key (kbd "C-c g") 'recompile))

(defun dkellner/watch-for-pdb (start end length)
  "Runs `pdb-mode' when the string \"(Pdb)\" is detected.
This function should be added to `after-change-functions'."
  (save-excursion
    (goto-char start)
    (if (search-forward "(Pdb)" end t)
        (dkellner/pdb-mode))))

(defun dkellner/setup-watch-for-pdb ()
  "Adds `dkellner/watch-for-pdb' to `after-change-functions' (buffer-local)."
  (add-hook 'after-change-functions 'dkellner/watch-for-pdb t t))
(add-hook 'compilation-mode-hook 'dkellner/setup-watch-for-pdb)

(provide 'dkellner-python)
