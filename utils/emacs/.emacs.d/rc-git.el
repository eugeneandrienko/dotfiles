(use-package magit)

(use-package git-gutter
  :ensure t
  :config
  (progn
    (global-git-gutter-mode +1)
    (git-gutter:linum-setup)
    (setq git-gutter:update-interval 0.02)))

(use-package git-gutter-fringe
  :ensure t
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
