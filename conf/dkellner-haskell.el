;; dkellner-haskell.el --- Haskell-specific configuration

;; See http://commercialhaskell.github.io/intero/
(use-package intero
  :config
  (add-hook 'haskell-mode-hook 'intero-mode)
  ;; Workaround until https://github.com/commercialhaskell/intero/pull/278
  ;; is merged and released through MELPA:
  (defalias 'format-message 'format))

(provide 'dkellner-haskell)
