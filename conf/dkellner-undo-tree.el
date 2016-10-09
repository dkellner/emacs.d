;; dkellner-undo-tree.el --- use undo-tree by default

(use-package undo-tree
  :config
  (progn
    (global-undo-tree-mode)
    (setq undo-tree-visualizer-diff t))
  :diminish undo-tree-mode)

(provide 'dkellner-undo-tree)
