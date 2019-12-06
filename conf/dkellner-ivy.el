;; dkellner-ivy.el --- incremental search and narrowing
;;
;; See https://github.com/abo-abo/swiper .

(use-package ivy
  :demand t
  :bind ("C-c C-r" . ivy-resume)
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) "
        ivy-height 6)
  (setq ivy-re-builders-alist '((t . ivy--regex-ignore-order)))
  (setq magit-completing-read-function 'ivy-completing-read)
  :diminish ivy-mode)

(use-package counsel
  :demand t
  :bind (("C-s" . counsel-grep-or-swiper))
  :config
  (counsel-mode 1)
  (setq counsel-grep-base-command
        "rg -i -M 120 --no-heading --line-number --color never '%s' %s")
  :diminish counsel-mode)

(use-package swiper)

(provide 'dkellner-ivy)
