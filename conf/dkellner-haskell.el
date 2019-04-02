;; dkellner-haskell.el --- Haskell-specific configuration

(use-package haskell-mode
  :config
  (setq haskell-mode-stylish-haskell-path "brittany"))

(use-package dante
  :hook (haskell-mode . dante-mode))

(provide 'dkellner-haskell)
