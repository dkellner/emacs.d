;; dkellner-windows-and-navigation.el

;; Window navigation with windmove. I use a pretty neat trick here: binding to
;; a character I rarely type allows me to use comfortable keystroke
;; combinations, but by typing it twice I can still insert the character.
(bind-keys :prefix-map windmove-map
           :prefix "¿"
           ("<left>" . windmove-left)
           ("<right>" . windmove-right)
           ("<up>" . windmove-up)
           ("<down>" . windmove-down)
           ("¿" . self-insert-command))

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
