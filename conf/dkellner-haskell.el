;; dkellner-haskell.el --- Haskell-specific configuration

;; See http://commercialhaskell.github.io/intero/
(use-package intero
  :config
  (add-hook 'haskell-mode-hook 'intero-mode))

(provide 'dkellner-haskell)
