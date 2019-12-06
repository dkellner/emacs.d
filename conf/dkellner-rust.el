(use-package rust-mode)

(use-package cargo
  :hook (rust-mode . cargo-minor-mode))

(use-package toml-mode)

(use-package lsp-mode
  :hook (rust-mode . lsp)
  :config
  (setq lsp-prefer-flymake nil))

(use-package flycheck-rust
  :hook (flycheck-mode . flycheck-rust-setup))

(provide 'dkellner-rust)
