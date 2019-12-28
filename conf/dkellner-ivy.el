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

(use-package ivy-posframe
  :config
  (setq ivy-posframe-parameters '((parent-frame nil))
        ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-center)))
  (ivy-posframe-mode 1)
  :diminish)

(setq posframe-arghandler #'dkellner/posframe-arghandler)

(setq dkellner/default-posframe-show-params
  '(:internal-border-width 1
    :internal-border-color "#504945"
    :background-color "#2b3c44"))

(defun dkellner/posframe-arghandler (buffer-or-name arg-name value)
  (or (plist-get dkellner/default-posframe-show-params arg-name) value))

(provide 'dkellner-ivy)
