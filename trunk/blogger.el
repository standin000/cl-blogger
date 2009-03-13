;; Blogger 用のスタイル
(setq muse-blogger-markup-strings
      (copy-tree muse-html-markup-strings))

(mapcar #'(lambda (arg)
            (rplacd (assoc (car arg) muse-blogger-markup-strings)
                    (cdr arg)))
        '((section           . "<h3>")
          (section-end       . "</h3>")
          (subsection        . "<h4>")
          (subsection-end    . "</h4>")
          (subsubsection     . "<h5>")
          (subsubsection-end . "</h5>")
          (section-other     . "<h6>")
          (section-other-end . "</h6>")
          (begin-example     . "<pre class='src'>")))
(muse-derive-style
 "blogger" "html"
 :header  ""
 :footer  ""
 :strings 'muse-blogger-markup-strings
 )

(defun blogger-post ()
  (interactive)
  (save-buffer)
  (muse-publish-this-file (muse-style "blogger") "/tmp" t)
  (slime-repl-send-string
   (format "(progn (require :blogger) (funcall (read-from-string \"blogger:post\") #p\"%s\"))"
           (buffer-file-name))))
