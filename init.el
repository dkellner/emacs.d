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
(setq use-package-verbose t)
(setq use-package-always-ensure t)

;; Make sure the following packages are available as I use them in my configs.
(use-package hydra)

;; I've split my configuration in multiple files and put them in 'conf/'.
;; Most of them automatically install packages, so if you for example are not
;; doing Haskell development at all, you will want to remove the line below
;; before starting Emacs.
(add-to-list 'load-path "~/.emacs.d/conf/")
(use-package dkellner-browser-bookmarks :ensure nil)
(use-package dkellner-company :ensure nil)
(use-package dkellner-docker :ensure nil)
(use-package dkellner-elfeed :ensure nil)
(use-package dkellner-elisp :ensure nil)
(use-package dkellner-email :ensure nil)
(use-package dkellner-engine-mode :ensure nil)
(use-package dkellner-haskell :ensure nil)
(use-package dkellner-helm :ensure nil)
(use-package dkellner-magit :ensure nil)
(use-package dkellner-misc :ensure nil)
(use-package dkellner-org :ensure nil)
(use-package dkellner-org-reveal :ensure nil)
(use-package dkellner-php :ensure nil)
(use-package dkellner-projectile :ensure nil)
(use-package dkellner-python :ensure nil)
(use-package dkellner-restclient :ensure nil)
(use-package dkellner-sgml :ensure nil)
(use-package dkellner-ui :ensure nil)
(use-package dkellner-undo-tree :ensure nil)
(use-package dkellner-windows-and-navigation :ensure nil)

;; This file is used to store user customization variables.
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)
