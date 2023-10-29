(use-package dashboard
  :ensure t
  :config
  (progn
    (dashboard-setup-startup-hook)
    (setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*"))))
  :custom
  (dashboard-center-content t)
  (dashboard-banner-logo-title "Welcome to Emacs")
  (dashboard-startup-banner 'official)
  (dashboard-items '((recents . 5)
                     (projects . 5)
                     (agenda . 5)))
  (dashboard-set-navigator nil)
  (dashboard-set-footer nil)
  (dashboard-set-init-info nil)
  (dashboard-agenda-prefix-format "%-12:c%?-12t% s"))
