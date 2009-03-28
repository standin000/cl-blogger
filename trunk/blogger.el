(defvar muse-blogger-markup-strings '()
  "Strings used for marking up text as XHMTL for Blogger.
Example:
((section . \"<h4>\")
 (section-end . \"</h4>\")
 (subsection . \"<h5>\")
 (subsection-end . \"</h5>\")
 (subsubsection . \"<h6>\")
 (subsubsection-end . \"</h6>\")
 (section-other . \"<div>\")
 (section-other-end . \"</div>\")
 (begin-example . \"<pre class='src'>\"))")

(muse-derive-style
 "blogger" "xhtml1.1"
 :header  ""
 :footer  ""
 :strings 'muse-blogger-markup-strings)

(defun blogger-post ()
  (interactive)
  (save-buffer)
  (muse-publish-this-file (muse-style "blogger") "/tmp" t)
  (slime-repl-send-string
   (format "(progn (require :blogger) (funcall (read-from-string \"blogger:post\") #p\"%s\"))"
           (buffer-file-name))))
