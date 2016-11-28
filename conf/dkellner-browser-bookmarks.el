;; dkellner-browser-bookmarks.el --- manage bookmarks in an org-file

(bind-key "C-c b" 'dkellner-helm-open-bookmark-in-browser)

(defcustom dkellner-browser-bookmarks-file "~/org/bookmarks.org"
  "Org-file containing bookmarks as HTTP(S)-URLs.

Currently only a very strict structure is supported, i.e. the
first level headlines will be treated as sections/groups and the
second level ones as bookmarks.

Example:
* Emacs
** https://www.gnu.org/software/emacs/
** http://sachachua.com/
* Search Engines
** https://duckduckgo.com/")

(defun dkellner-helm-open-bookmark-in-browser ()
  "Interactively selects and opens a bookmark in the default browser.

It uses `org-open-link-from-string' and thus `browse-url'
internally for actually sending the URL to the browser. You
should refer to its documentation if you want to change the
browser."
  (interactive)
  (helm :sources (dkellner-bb-helm-sources)
        :buffer "*helm browser bookmarks*"))

(defun dkellner-bb-helm-sources ()
  (with-current-buffer
      (find-file-noselect (expand-file-name dkellner-browser-bookmarks-file))
    (org-element-map (org-element-parse-buffer) 'headline
      (lambda (h)
        (when (= (org-element-property :level h) 1)
          (dkellner-bb-section-to-helm-source h))))))

(defun dkellner-bb-section-to-helm-source (headline)
  `((name . ,(org-element-property :raw-value headline))
    (candidates . ,(dkellner-bb-contents-to-helm-candidates
                    (org-element-contents headline)))
    (action . org-open-link-from-string)))

(defun dkellner-bb-contents-to-helm-candidates (contents)
  (org-element-map contents 'headline
    (lambda (h) (org-element-property :raw-value h))))

(provide 'dkellner-browser-bookmarks)
