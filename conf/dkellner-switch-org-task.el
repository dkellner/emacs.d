;; dkellner-switch-org-task.el --- super-fast task switching with ivy-mode

(require 'dash)

(bind-key "C-c t" #'dkellner/switch-org-task)

(defun dkellner/switch-org-task ()
  (interactive)
  (let ((tasks (dkellner/tasks-for-switching)))
    (ivy-read "Switch to task: " (map-keys tasks)
              :require-match t
              :action (lambda (e) (dkellner/org-clock-in-silently
                                   (cdr (assoc e tasks)))))))

(defun dkellner/tasks-for-switching ()
  (if (org-clock-is-active)
      (dkellner/tasks-surrounding-active-clock)
    (dkellner/all-tasks-in-agenda-files)))

(defun dkellner/all-tasks-in-agenda-files ()
  (-mapcat #'dkellner/tasks-in-org-file org-agenda-files))

(defun dkellner/tasks-in-org-file (org-file)
  (with-current-buffer (find-file-noselect (expand-file-name org-file))
    (org-element-map (org-element-parse-buffer) 'headline
      #'dkellner/org-element-to-marker-map)))

(defun dkellner/tasks-surrounding-active-clock ()
  (with-current-buffer (org-clock-is-active)
    (save-excursion
      (save-restriction
        (widen)
        (goto-char org-clock-marker)
        (org-save-outline-visibility nil
          (outline-show-subtree)
          (goto-char org-clock-marker)
          (outline-up-heading 1)
          (org-narrow-to-subtree)
          (org-element-map (org-element-parse-buffer) 'headline
            (lambda (h) (when (> (org-element-property :level h)
                                 (org-element-property :level (org-element-at-point)))
                          (dkellner/org-element-to-marker-map h)))))))))

(defun dkellner/org-element-to-marker-map (element)
  (let ((m (make-marker)))
    (set-marker m (org-element-property :begin element))
    `(,(org-element-property :raw-value element) . ,m)))

(defun dkellner/org-clock-in-silently (clock-marker)
  (with-current-buffer (marker-buffer clock-marker)
    (goto-char clock-marker)
    (org-clock-in)
    (basic-save-buffer)))

(provide 'dkellner-switch-org-task)
