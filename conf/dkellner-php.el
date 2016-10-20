;; dkellner-php.el --- PHP-specific configuration

(use-package php-mode
  :config
  (use-package company-php)
  (use-package flycheck
    :diminish flycheck-mode)
  (add-hook 'php-mode-hook 'dkellner/php-mode-hook))

(defun dkellner/php-mode-hook ()
  "Custom settings for php-mode"
  (add-to-list 'company-backends '(company-ac-php-backend company-dabbrev))
  (flycheck-mode))

(provide 'dkellner-php)
