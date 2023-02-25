(use-package org
  :bind
  (("C-c a" . org-agenda)
   ("C-c c" . org-capture))
  :custom
  (org-catch-invisible-edits t)
  (org-todo-keywords '((sequence "TODO(t)" "VERIFIED(v)" "|" "DONE(d)" "CANCELLED(c)")))
  (org-todo-keyword-faces '(("CANCELLED" . (:foreground "blue" :weight bold))
                            ("VERIFIED" . (:foreground "orange" :weight bold))))
  (org-clock-out-remove-zero-time-clocks t)
  (org-archive-location "~/rsync/org/archive.org_archive::")
  (org-archive-save-context-info (quote (file olpath)))
  (org-archive-subtree-save-file-p t "Save archive buffer immediately")
  (org-directory "~/rsync/org")
  (org-default-notes-file "~/rsync/org/notes.org")
  (org-agenda-files  (quote ("~/rsync/org")))
  (org-capture-templates '(("n" "Note" entry (file "~/rsync/org/notes.org")
                            "* %? %^g\n"
                            :empty-lines 1)
                           ("t" "Todo" entry (file+regexp "~/rsync/org/todo.org" "New TODOs")
                            "** TODO %?\n"
                            :empty-lines-after 2)
                           ("d" "Daily" entry (file "~/rsync/org/daily.org")
                            "* TODO %? %^g\nSCHEDULED: %^t\n"
                            :empty-lines-before 0
                            :empty-lines-after 1)
                           ("e" "Daily+time" entry (file "~/rsync/org/daily.org")
                            "* TODO %? %^g\nSCHEDULED: %^T\n"
                            :empty-lines-before 0
                            :empty-lines-after 1)))
  (org-startup-indented t "Indent headlines")
  (org-agenda-span 'day)
  (org-hide-emphasis-markers t)
  (org-src-fontify-natively t "Syntax highlight in BEGIN_SRC blocks")
  (org-confirm-babel-evaluate nil "Dunno prompt before running the code in org")
  :config
  (progn
    (add-hook 'org-mode-hook
              '(lambda()
                 (progn
                   (add-to-list 'org-file-apps
                                '("\\.jpg\\'" . "sxiv %s"))
                   (add-to-list 'org-file-apps
                                '("\\.png\\'" . "sxiv %s")))))
    (org-babel-do-load-languages 'org-babel-load-languages
                                 '((shell  . t)))))

(use-package gnuplot)
