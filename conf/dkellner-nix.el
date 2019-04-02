;; dkellner-nix.el --- NixOS-specific configuration

(use-package nix-mode
  :mode ("\\.nix\\'" . nix-mode))

(use-package nix-sandbox
  :config
  (setq flycheck-command-wrapper-function
        (lambda (command) (apply 'nix-shell-command (nix-current-sandbox) command))
        flycheck-executable-find
        (lambda (cmd) (nix-executable-find (nix-current-sandbox) cmd))
        haskell-process-wrapper-function
        (lambda (args) (apply 'nix-shell-command (nix-current-sandbox) args))))

(provide 'dkellner-nix)
