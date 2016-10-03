;; dkellner-sgml.el --- fancy stuff for editing SGML/HTML

;; Enable zencoding-mode for all SGML-buffers. To try, just type a CSS-selector
;; (like "ul>li*3") and press C-j.
;; See https://www.emacswiki.org/emacs/ZenCoding .
(use-package zencoding-mode
  :config
  (add-hook 'sgml-mode-hook 'zencoding-mode))

(provide 'dkellner-sgml)
