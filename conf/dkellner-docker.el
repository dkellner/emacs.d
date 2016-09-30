;; dkellner-docker.el --- manage docker from Emacs
;;
;; See https://github.com/Silex/docker.el .

(mapc 'dkellner/install-package-if-missing '(docker
                                             dockerfile-mode))
