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
                           ("t" "Todo" entry (file "~/rsync/org/todo.org")
                            "* TODO %? %^g\n"
                            :empty-lines-after 1)
                           ("T" "Todo+time" entry (file "~/rsync/org/todo.org")
                            "* TODO %? %^g\nSCHEDULED: %^t\n"
                            :empty-lines-after 1)))
  (org-startup-indented t "Indent headlines")
  (org-hide-leading-stars t "Hide leading stars")
  (org-agenda-span 'day)
  (org-hide-emphasis-markers t)
  (org-adapt-indentation t)
  (org-auto-align-tags t)
  (org-fold-catch-invisible-edits 'show-and-error)
  (org-special-ctrl-a/e t)
  (org-insert-heading-respect-content t)
  (org-src-fontify-natively t "Syntax highlight in BEGIN_SRC blocks")
  (org-src-tab-acts-natively t)
  (org-edit-src-content-indentation 0)
  (org-confirm-babel-evaluate nil "Dunno prompt before running the code in org")
  (org-image-actual-width 600)
  :config
  (progn
    (add-hook 'org-mode-hook
              #'(lambda()
                  (progn
                    (add-to-list 'org-file-apps
                                 '("\\.jpg\\'" . "sxiv %s"))
                    (add-to-list 'org-file-apps
                                 '("\\.png\\'" . "sxiv %s")))))
    (org-babel-do-load-languages 'org-babel-load-languages
                                 '((shell  . t)))
    (define-key org-mode-map (kbd "C-c <up>") nil)
    (define-key org-mode-map (kbd "C-c <down>") nil)
    (define-key org-mode-map (kbd "C-c <left>") nil)
    (define-key org-mode-map (kbd "C-c <right>") nil)
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
      (set-face-attribute (car face) nil :weight 'regular :height (cdr face))) ))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

(use-package org-alert
  :custom
  (alert-default-style 'libnotify)
  :config
  (progn
    (setq org-alert-notification-title "OrgMode")
    (setq org-alert-interval 1800
          org-alert-notify-cutoff 10
          org-alert-notify-after-event-cutoff 10)))

(use-package company-org-block
  :custom
  (company-org-block-edit-style 'inline)
  :hook ((org-mode . (lambda ()
                       (setq-local company-backends '(company-org-block))
                       (company-mode +1)))))
