;; dkellner-package.el --- setup the Emacs package manager
;;
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Packages.html

(require 'package)

(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(defun dkellner/install-package-if-missing (package)
  "Installs a package if it is missing.

I use this function in my different configuration snippets so I don't have to
remember which packages to install on a fresh installation of Emacs."
  (unless (package-installed-p package)
    (package-install package)))
