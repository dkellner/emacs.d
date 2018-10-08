;; dkellner-windows-and-navigation.el


;; Enable winner-mode and enhance its functionality by making the keybindings
;; "sticky" - i.e. let you press C-c <left> to undo once, and then just <left>
;; for another undo, and so on.
(winner-mode 1)
(defhydra dkellner/winner-undo (:body-pre (winner-undo))
  ("<left>" winner-undo)
  ("<right>" winner-redo))
(bind-key* "C-c <left>" #'dkellner/winner-undo/body)

(defun dkellner/bring-buffer (buffer-or-name)
  "Brings a buffer to the current window. If the buffer is currently displayed
in another window, it will be swapped with the current buffer."
  (interactive "bBuffer: ")
  (let ((current-window (get-buffer-window (current-buffer)))
        (other-window (get-buffer-window buffer-or-name)))
    (when other-window (set-window-buffer other-window (current-buffer)))
    (switch-to-buffer buffer-or-name)))

(bind-key "C-x b" #'dkellner/bring-buffer)

(provide 'dkellner-windows-and-navigation)
