(require 'ox-publish)

(setq auto-save-default nil
      make-backup-files nil)

(setq website-default-page-attributes
      (list :with-author nil                      ;; Don't include author name
            :with-creator t                       ;; Include Emacs and Org
                                                  ;; versions in footer
            :with-date t
            :with-toc nil                         ;; Include a table of contents
            :section-numbers nil                  ;; Don't include section
                                                  ;; numbers
            :time-stamp-file nil                  ;; Don't include time stamp in
                                                  ;; file
            :html-doctype "html5"
            :html-html5-fancy t
            :html-validation-link nil             ;; Don't show validation link
            :html-head-include-scripts nil        ;; Use our own scripts
            :html-head-include-default-style nil  ;; Use our own styles
            :html-head "<link rel=\"stylesheet\" href=\"/files/main.css\" />"
            :html-preamble
            "<nav>
<b><a href=\"/\">Home</a></b>
<a href=\"/pages/about.html\">about</a>
</nav>"
            :html-postamble "<footer></footer>"
            ))

(defun my/org-sitemap-date-entry-format (entry style project)
  "Format ENTRY in org-publish PROJECT Sitemap format ENTRY ENTRY STYLE format that includes date."
  (let ((filename (org-publish-find-title entry project)))
    (if (= (length filename) 0)
        (format "*%s*" entry)
      (format "[[file:%s][%s]] {{{timestamp(%s)}}}"
              entry
              filename
              (format-time-string "%b %e %Y"
                                  (org-publish-find-date entry project))))))

(setq org-export-global-macros
      '(("timestamp" . "@@html:<span class=\"timestamp\">$1</span>@@")))

(setq org-publish-project-alist
      (list
       (append '("blog"
                 :recursive t
                 :base-directory "./content"
                 :base-extension "org"
                 :publishing-function org-html-publish-to-html
                 :publishing-directory "./html"
                 :auto-sitemap t
                 :sitemap-title "Posts"
                 :sitemap-filename "index.org"
                 :sitemap-format-entry my/org-sitemap-date-entry-format
                 :sitemap-sort-files anti-chronologically)
               website-default-page-attributes)

       (append '("pages"
                 :recursive t
                 :base-directory "./pages"
                 :base-extension "org"
                 :publishing-function org-html-publish-to-html
                 :publishing-directory "./html/pages"
                 :auto-sitemap nil)
               website-default-page-attributes)

       '("static"
         :base-directory "./files"
         :base-extension "css\\|txt\\|jpg\\|jpeg\\|gif\\|png\\|pdf"
         :recursive t
         :publishing-directory  "./html/files/"
         :publishing-function org-publish-attachment)

       (list "kruzenshtern.org"
             :components '("blog" "pages" "static"))))

;; Generate the site output
(org-publish-all t)

(message "Build complete!")
