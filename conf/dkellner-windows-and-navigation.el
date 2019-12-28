;; dkellner-windows-and-navigation.el

(use-package shackle
  :config
  (setq shackle-rules
        '((("^\\*Capture\\*$"
            "^\\*Org Select\\*$"
            "^CAPTURE.*\\.org$")
           :regexp t
           :custom dkellner/shackle-dynamic-split)))
  (shackle-mode 1))

;; see https://emacs.stackexchange.com/a/37652

(defun dkellner/shackle-smart-split-dir ()
  (if (< (/ (float (window-pixel-width))
            (window-pixel-height))
         1.3)
      'below
    'right))

(defun dkellner/shackle-dynamic-split (buffer alist plist)
  (let
      ((frame (shackle--splittable-frame))
       (window (if (eq (dkellner/shackle-smart-split-dir) 'below)
                   (split-window-below)
                 (split-window-right))))
    (prog1
        (window--display-buffer buffer window
                                'window alist display-buffer-mark-dedicated)
      (when window
        (setq shackle-last-window window
              shackle-last-buffer buffer))
      (unless (cdr (assq 'inhibit-switch-frame alist))
        (window--maybe-raise-frame frame)))))

;; from https://github.com/hlissner/doom-emacs/blob/master/core/core-popups.el

(defun dkellner/suppress-delete-other-windows (orig-fn &rest args)
  (cl-letf (((symbol-function 'delete-other-windows)
             (symbol-function 'ignore)))
    (apply orig-fn args)))

(advice-add #'org-capture-place-template
            :around #'dkellner/suppress-delete-other-windows)

(defun dkellner/org-pop-to-buffer (&rest args)
  "Use `pop-to-buffer' instead of `switch-to-buffer' to open buffer.'"
  (let ((buf (car args)))
    (pop-to-buffer
     (cond ((stringp buf) (get-buffer-create buf))
           ((bufferp buf) buf)
           (t (error "Invalid buffer %s" buf))))))

(advice-add #'org-switch-to-buffer-other-window
            :override #'dkellner/org-pop-to-buffer)

;; Enable winner-mode and enhance its functionality by making the keybindings
;; "sticky" - i.e. let you press C-c <left> to undo once, and then just <left>
;; for another undo, and so on.
(winner-mode 1)
(defhydra dkellner/winner-undo (:body-pre (winner-undo))
  ("<left>" winner-undo)
  ("<right>" winner-redo))
(bind-key* "C-c <left>" #'dkellner/winner-undo/body)

(provide 'dkellner-windows-and-navigation)
