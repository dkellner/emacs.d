;; init.el --- Emacs configuration of Dominik Kellner <dkellner@dkellner.de>.

;; Run in server mode. This is needed for running `emacsclient` and I mostly
;; use it for integration with mutt.
(server-mode 1)

;; I've split my configuration in multiple files and put them in 'conf/'.
(add-to-list 'load-path "~/.emacs.d/conf/")

;; This one has to be loaded first as other config files reference
;; `dkellner/install-package-if-missing' defined there:
(load-library "dkellner-package")

;; All other configs are just loaded in alphabetical order:
(load-library "dkellner-ace-window")
(load-library "dkellner-company")
(load-library "dkellner-docker")
(load-library "dkellner-email")
(load-library "dkellner-haskell")
(load-library "dkellner-helm")
(load-library "dkellner-magit")
(load-library "dkellner-misc")
(load-library "dkellner-org")
(load-library "dkellner-projectile")
(load-library "dkellner-python")
(load-library "dkellner-restclient")
(load-library "dkellner-ui")

;; This file is used to store user customization variables.
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)
