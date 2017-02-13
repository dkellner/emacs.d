;; dkellner-browser-bookmarks.el --- manage bookmarks in an org-file

(bind-key "C-c b" #'dkellner/open-browser-bookmark)

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

(defun dkellner/open-browser-bookmark ()
  "Interactively selects and opens a bookmark in the default browser.

It uses `org-open-link-from-string' and thus `browse-url'
internally for actually sending the URL to the browser. You
should refer to its documentation if you want to change the
browser."
  (interactive)
  (let ((bookmarks (dkellner/browser-bookmarks-in-org-file
                    dkellner-browser-bookmarks-file)))
    (ivy-read "Open bookmark: " (map-keys bookmarks)
              :require-match t
              :action (lambda (e) (org-open-link-from-string
                                   (cdr (assoc e bookmarks)))))))

(defun dkellner/browser-bookmarks-in-org-file (org-file)
  (with-current-buffer (find-file-noselect (expand-file-name org-file))
    (org-element-map (org-element-parse-buffer) 'headline
      (lambda (h)
        (when (= (org-element-property :level h) 2)
          (dkellner/browser-bookmark-to-key-value h))))))

(defun dkellner/browser-bookmark-to-key-value (bookmark)
  (let* ((section (org-element-property :parent bookmark))
         (section-prefix (concat (org-element-property :raw-value section)
                                 " :: "))
         (raw-value (org-element-property :raw-value bookmark))
         (regexp "\\[\\[\\(.+?\\)]\\[\\(.+?\\)]]"))
    (if (string-match regexp raw-value)
        `(,(concat section-prefix (match-string 2 raw-value)) .
          ,(match-string 1 raw-value))
      `(,(concat section-prefix raw-value) . ,raw-value))))

(provide 'dkellner-browser-bookmarks)
