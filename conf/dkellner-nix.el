;; dkellner-nix.el --- NixOS-specific configuration

(use-package nix-mode)

(use-package nix-sandbox
  :config
  (use-package company-nixos-options)
  (add-to-list 'company-backends 'company-nixos-options)
  (setq
   flycheck-command-wrapper-function (lambda (command) (apply 'nix-shell-command (nix-current-sandbox) command))
   flycheck-executable-find (lambda (cmd) (nix-executable-find (nix-current-sandbox) cmd)))
  (setq haskell-process-wrapper-function (lambda (args) (apply 'nix-shell-command (nix-current-sandbox) args))))

(provide 'dkellner-nix)
