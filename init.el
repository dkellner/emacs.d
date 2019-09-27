;; init.el --- Emacs configuration of Dominik Kellner <dkellner@dkellner.de>

;; This file is used to store user customization variables.
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;; Disable the package manager and make sure `use-package' is installed. I use
;; it to tidy the rest of my configuration.
(require 'package)
(setq package-archives nil
      package-enable-at-startup nil)
(package-initialize)
(require 'use-package)

;; Make sure the following packages are available as I use them in my configs.
(use-package diminish)
(use-package hydra)

;; `no-littering' needs to be loaded as early as possible, see
;; https://github.com/emacscollective/no-littering#usage for details.
(use-package no-littering)

;; I've split my configuration in multiple files and put them in 'conf/'.
;; Most of them automatically install packages, so if you for example are not
;; doing Haskell development at all, you will want to remove the line below
;; before starting Emacs.
(add-to-list 'load-path (expand-file-name "conf" user-emacs-directory))
(require 'dkellner-browser-bookmarks)
(require 'dkellner-company)
(require 'dkellner-docker)
(require 'dkellner-elisp)
(require 'dkellner-email)
(require 'dkellner-eshell)
(require 'dkellner-exwm)
(require 'dkellner-git)
(require 'dkellner-haskell)
(require 'dkellner-ivy)
(require 'dkellner-misc)
(require 'dkellner-nix)
(require 'dkellner-org)
(require 'dkellner-php)
(require 'dkellner-projectile)
(require 'dkellner-python)
(require 'dkellner-restclient)
(require 'dkellner-switch-org-task)
(require 'dkellner-ui)
(require 'dkellner-undo-tree)
(require 'dkellner-web-mode)
(require 'dkellner-windows-and-navigation)

(provide 'init)
