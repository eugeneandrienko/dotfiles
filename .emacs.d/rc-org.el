(setq load-path (cons "~/.emacs.d/elisp/org/" load-path))
(require 'org-install)

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

(global-set-key "\e\el" 'org-store-link)
(global-set-key "\e\ec" 'org-capture)
(global-set-key "\e\ea" 'org-agenda)
(global-set-key "\e\eb" 'org-iswitchb)

(setq org-agenda-files (quote ("~/.org/")))
(setq org-directory "~/.org/")

;my prefer identation
(setq org-startup-indented t)

;;logging stuff
(setq org-log-done (quote time))
(setq org-log-into-drawer nil)
(setq org-log-redeadline (quote note))
(setq org-log-reschedule (quote time))
;todo keywords
(setq org-todo-keywords
      (quote ((sequence "TODO(t!)" "NEXT(n!)" "WAITING(w@/!)" "STARTED(s!)" "|" "DONE(d!/!)" "CANCELLED(c@/!)")
              (sequence "QUOTE(Q!)" "QUOTED(D!)" "|" "APPROVED(A@)" "EXPIRED(E@)" "REJECTED(R@)")
              (sequence "OPEN(O!)" "|" "CLOSED(C!)"))))

;;org-mode settings
(setq org-mobile-directory "~/Dropbox/org-mode/MobileOrg")
;Set to the name of the file where new notes will be stored
(setq org-mobile-inbox-for-pull "~/.org/flagged.org")
