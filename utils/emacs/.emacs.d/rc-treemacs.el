(use-package treemacs
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-1") #'treemacs))
  :config
  (progn
    (setq treemacs-deferred-git-apply-delay 0.5
          treemacs-display-in-side-window t
          treemacs-eldoc-display 'simple
          treemacs-file-follow-delay 0.2
          treemacs-follow-after-init t
          treemacs-expand-after-init t
          treemacs-hide-dot-git-directory t
          treemacs-indentation 2
          treemacs-indentation-string " "
          treemacs-position 'left
          treemacs-show-hidden-files t
          treemacs-width 35
          treemacs-width-increment 1
          treemacs-width-is-initially-locked t
          treemacs-no-png-images t)
    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode 'always)
    (treemacs-git-mode 'simple)
    (defun treemacs-ignore-dot-settings(filename abs-path)
      (or
       (string= filename ".settings")
       (string= filename ".classpath")
       (string= filename ".factorypath")
       (string= filename ".project")))
    (add-to-list 'treemacs-ignored-file-predicates #'treemacs-ignore-dot-settings))
  :bind
  (:map global-map
        ("M-1" . treemacs)))

(use-package treemacs-projectile
  :after (treemacs projectile))
