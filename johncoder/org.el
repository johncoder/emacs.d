(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cc" 'org-capture)

(setq org-log-done t)

(setq org-agenda-files (list "~/org/work.org"
                             "~/org/study.org"
                             "~/org/home.org"))

(custom-set-faces '(org-link ((t (:underline t)))))

;;;; --------------------------------------------------
;;;; TEMPLATE PLACEHOLDERS
;;;; --------------------------------------------------
;;;; %U       Inactive timestamp
;;;; %^{Name} Prompt for something
;;;; %a       Annotation (org-store-link)
;;;; %i       Active region
;;;; %?       Cursor ending location

(setq org-capture-templates
      '(("c" "Clock item"
         item (clock)
         "  - %i%?")
        ("g" "Thought"
         entry (file "~/org/thoughts.org")
         "* [%U] %?\n")
        ("f" "Follow Up"
         entry (file+headline "~/org/todo.org" "inbox")
         "* TODO %?\n")
        ("j" "Append journal entry"
         entry (file+datetree "~/org/journal.org")
	 "* %U %^{Title}\n%?")
        ))
