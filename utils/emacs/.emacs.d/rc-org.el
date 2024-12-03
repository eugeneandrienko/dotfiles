(use-package htmlize
  :pin melpa
  :demand
  :delight)

(use-package org
  :bind
  (("C-c a" . org-agenda)
   ("C-c c" . org-capture)
   :map org-mode-map
   ("C-c <up>" . nil)
   ("C-c <down>" . nil)
   ("C-c <left>" . nil)
   ("C-c <right>" . nil))
  :custom
  (org-catch-invisible-edits t "Disallow invisible edits in org file")
  (org-fold-catch-invisible-edits 'show-and-error "Show invisible edits")
  (org-todo-keywords '((sequence "TODO(t)" "VERIFIED(v)"
                                 "|"
                                 "DONE(d)" "CANCELLED(c)"))
                     "My custom set of TODO keywords")
  (org-todo-keyword-faces '(("CANCELLED" . (:foreground "blue" :weight bold))
                            ("VERIFIED" . (:foreground "orange" :weight bold)))
                          "Custom faces for some TODO keywords")
  (org-clock-out-remove-zero-time-clocks t "Do not clock zero seconds")
  (org-archive-location "~/rsync/org/archive.org_archive::" "Default archive path")
  (org-archive-save-context-info (quote (file olpath)) "Additional info to save to archive")
  (org-archive-subtree-save-file-p t "Save archive buffer immediately")
  (org-directory "~/rsync/org" "Default catalog with Org files")
  (org-default-notes-file "~/rsync/org/notes.org" "Default file with notes")
  (org-agenda-files  '("~/rsync/org/todo.org") "File(s) to use in Agenda")
  (org-capture-templates '(("n" "Note" entry (file "~/rsync/org/notes.org")
                            "* %? %^g\n"
                            :empty-lines 1)
                           ("t" "Todo" entry (file "~/rsync/org/todo.org")
                            "* TODO %? %^g\n"
                            :empty-lines-after 1)
                           ("T" "Todo+time" entry (file "~/rsync/org/todo.org")
                            "* TODO %? %^g\nSCHEDULED: %^t\n"
                            :empty-lines-after 1))
                         "Custom capture templates")
  (org-startup-indented t "Indent headlines")
  (org-hide-leading-stars t "Hide stars")
  (org-agenda-span 'day "Show agenda only for day")
  (org-hide-emphasis-markers t "Hide emphasis markers, show only the xtext")
  (org-adapt-indentation t "Indent headlines")
  (org-auto-align-tags t "Auto align the tags")
  (org-special-ctrl-a/e t "Special behaviour for C-a C-e to protect trees")
  (org-special-ctrl-k t "Special behaviour for C-k to protect trees")
  (org-insert-heading-respect-content t "Respect indentation when M-RET")
  (org-src-fontify-natively t "Syntax highlight in BEGIN_SRC blocks")
  (org-src-tab-acts-natively t "Tab acts like in code buffer in BEGIN_SRC blocks")
  (org-src-preserve-indentaion t)
  (org-src-window-setup 'current-window "Edit source block in current window")
  (org-edit-src-content-indentation 0 "No additinal indentation in BEGIN_SRC blocks")
  (org-confirm-babel-evaluate nil "Dunno prompt before running the code in org")
  (org-image-actual-width 600 "Width of inline images")
  (org-enforce-todo-depencencies t "Undone TODO entries will block switching parent to DONE")
  (org-enforce-todo-checkbox-dependencies t "Unchecked boxes will block switching parent to DONE")
  (org-ellipsis "↴" "Nicer ellipses")
  (org-fontify-quote-and-verse-blocks t "Stand out quotes")
  (org-pretty-entities t "Make LaTeX looks good")
  (org-pretty-entities-include-sub-superscripts nil "Don't prettify sub/superscripts")
  (org-read-date-prefer-future 'time "Incomplete dates refer to future dates & times")
  (org-plantuml-jar-path "~/bin/plantuml/plantuml.jar")
  (org-export-backends '(ascii html latex md)
                       "Export configuration")
  :config
  (add-hook 'org-mode-hook
            #'(lambda()
                (progn
                  (add-to-list 'org-file-apps
                               '("\\.jpg\\'" . "sxiv %s"))
                  (add-to-list 'org-file-apps
                               '("\\.png\\'" . "sxiv %s")))))
  (org-babel-do-load-languages 'org-babel-load-languages
                               '((shell  . t)
                                 (dot . t)
                                 (plantuml . t)))
  ;; Replace list hyphen with dot
  (font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1() (compose-region (match-beginning 1) (match-end 1) "•"))))))
  ;; Set faces for heading levels
  (dolist (face '((org-level-1 . 1.2)
                  (org-level-2 . 1.1)
                  (org-level-3 . 1.05)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.1)
                  (org-level-6 . 1.1)
                  (org-level-7 . 1.1)
                  (org-level-8 . 1.1)))
    (set-face-attribute (car face) nil :weight 'regular :height (cdr face))))

(use-package org-bullets
  :pin melpa
  :commands org-bullets-mode
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

(use-package org-alert
  :pin melpa
  :disabled
  :requires org
  :custom
  (alert-default-style 'libnotify)
  :config
  (setq org-alert-notification-title "OrgMode")
  (setq org-alert-interval 1800
        org-alert-notify-cutoff 10
        org-alert-notify-after-event-cutoff 10))

(use-package toc-org
  :pin melpa
  :hook (org-mode . toc-org-mode)
  :config
  (defun toc-org-hrefify-blog (str &optional hash)
    (concat "* " (toc-org-format-visible-link str))))

(use-package org-jekyll
  :load-path "~/rsync/blog/"
  :ensure nil
  :commands org-jekyll-init
  :hook (org-mode . org-jekyll-init))
