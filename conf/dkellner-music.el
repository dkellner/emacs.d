;;; dkellner-music.el

(use-package emms
  :config
  (emms-standard)
  (emms-default-players)
  (emms-mode-line 0)
  (emms-playing-time 0)
  (add-to-list 'emms-player-list 'emms-player-mpd))

(provide 'dkellner-music)
