;; dkellner-ivy.el --- incremental search and narrowing
;;
;; See https://github.com/abo-abo/swiper .

(use-package ivy
  :bind ("C-c C-r" . ivy-resume)
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (setq ivy-re-builders-alist '((t . ivy--regex-ignore-order)))
  (setq magit-completing-read-function 'ivy-completing-read)
  :diminish ivy-mode)

(use-package counsel
  :bind (("M-x" . counsel-M-x)
         ("M-y" . counsel-yank-pop)
         ("C-x C-f" . counsel-find-file))
  :config
  (setcdr (assoc 'counsel-M-x ivy-initial-inputs-alist) ""))

(use-package swiper
  :bind ("C-s" . swiper))

(provide 'dkellner-ivy)
