;; dkellner-windows-and-navigation.el

;; Window navigation with windmove. I use a pretty neat trick here: binding to
;; a character I rarely type allows me to use comfortable keystroke
;; combinations, but by typing it twice I can still insert the character.
(defhydra dkellner/windmove (:exit t)
  ("<left>" windmove-left "left")
  ("<right>" windmove-right "right")
  ("<up>" windmove-up "up")
  ("<down>" windmove-down "down")
  ("¿" self-insert-command "insert ¿"))
(bind-key* "¿" #'dkellner/windmove/body)

;; Enable winner-mode and enhance its functionality by making the keybindings
;; "sticky" - i.e. let you press C-c <left> to undo once, and then just <left>
;; for another undo, and so on.
(winner-mode 1)
(defhydra dkellner/winner-undo (:body-pre (winner-undo))
  ("<left>" winner-undo)
  ("<right>" winner-redo))
(bind-key* "C-c <left>" #'dkellner/winner-undo/body)

(provide 'dkellner-windows-and-navigation)
