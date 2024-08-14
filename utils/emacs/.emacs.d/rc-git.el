(use-package magit
  :pin melpa
  :bind
  ("C-x g" . magit)
  :custom
  (magit-display-buffer-function
   #'magit-display-buffer-same-window-except-diff-v1
   "Show magit screens in the same window"))

(use-package git-gutter
  :pin melpa
  :custom
  (git-gutter:update-interval 0.02 "Update interval")
  :delight
  :config
  (global-git-gutter-mode +1)
  (git-gutter:linum-setup))

(use-package git-gutter-fringe
  :pin melpa
  :requires git-gutter
  :after git-gutter
  :config
  (setq-default left-fringe-width 20)
  (setq-default right-fringe-width 40)
  (fringe-helper-define 'git-gutter-fr:added '(center repeated)
    "..XXXX.."
    "..XXXX.."
    "..XXXX.."
    "..XXXX..")
  (fringe-helper-define 'git-gutter-fr:modified '(center repeated)
    "..XXXX.."
    "..XXXX.."
    "..XXXX.."
    "..XXXX..")
  (fringe-helper-define 'git-gutter-fr:deleted 'bottom
    "XXXXXXXX"
    "XXXXXXXX"
    "XXXXXXXX"
    "XXXXXXXX")
  (set-face-foreground 'git-gutter-fr:added    "lime green")
  (set-face-foreground 'git-gutter-fr:modified "dark goldenrod")
  (set-face-foreground 'git-gutter-fr:deleted  "firebrick"))
