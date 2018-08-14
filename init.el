;; init.el --- Emacs configuration of Dominik Kellner <dkellner@dkellner.de>

;; Configure the package manager and make sure `use-package' is installed.
;; I use it to tidy the rest of my configuration.
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(setq package-enable-at-startup nil)
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; Make sure the following packages are available as I use them in my configs.
(use-package diminish)
(use-package hydra)

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
(require 'dkellner-engine-mode)
(require 'dkellner-eshell)
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
(require 'dkellner-sgml)
(require 'dkellner-switch-org-task)
(require 'dkellner-ui)
(require 'dkellner-undo-tree)
(require 'dkellner-web-mode)
(require 'dkellner-windows-and-navigation)

;; This file is used to store user customization variables.
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

(provide 'init)
