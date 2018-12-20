;; dkellner-haskell.el --- Haskell-specific configuration

(use-package haskell-mode
  :config
  (setq haskell-stylish-on-save t
        haskell-mode-stylish-haskell-path "brittany"))

;; See http://commercialhaskell.github.io/intero/
(use-package intero
  :config
  (add-hook 'haskell-mode-hook #'intero-mode))

(provide 'dkellner-haskell)
