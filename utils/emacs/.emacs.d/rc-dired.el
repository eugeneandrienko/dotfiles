(use-package dired
  :ensure nil
  :bind
  ("C-x C-d" . dired)
  :custom
  (dired-listing-switches "-lah" "Arguments for ls")
  (dired-kill-when-opening-new-dired-buffer t "Only one Dired buffer")
  (image-dired-thumb-margin 5 "Margin between thumbnails")
  (dired-dwim-target t "Suggest already opened Dired buffers for file operations")
  (dired-recursive-copies 'always "Copy recursively")
  (dired-recursive-deletes 'always "Delete recursively")
  (dired-guess-shell-alist-user (list
                                 (list "\\.\\([Jj][Pp][Ee]?[Gg]\\|[Pp][Nn][Gg]\\|[Tt][Ii][Ff]\\{2\\}\\|[Ww][Ee][Bb][Pp]\\)$"
                                       "sxiv -t * "
                                       "sxiv -o * | xargs rm -f"
                                       "sxiv -o * | xargs gimp"
                                       "for i in * ; do convert \"$i\" -resize 1080x1080^ resized_\"$i\"; done"
                                       "for i in * ; do convert \"$i\" -resize 2560x2560^ resized_\"$i\"; done")
                                 (list "\\.ORF$"
                                       "rawtherapee * ")
                                 (list "\\.[Gg][Pp][Xx]$"
                                       "qmapshack * "))
                                "Special commands for files with specified extensions")
  (wdired-allow-to-change-permissions t "Change permissions in WDired")
  (dired-mouse-drag-files t "Enable mouse dragging to another apps")
  (dired-free-space nil "Don't show free space line")
  :config
  (defun mydired-sort ()
    "Sort dired listings with directories first."
    (save-excursion
      (let (buffer-read-only)
        (forward-line 2) ;; beyond dir. header
        (sort-regexp-fields t "^.*$" "[ ]*." (point) (point-max)))
      (set-buffer-modified-p nil)))
  (defadvice dired-readin
      (after dired-after-updating-hook first () activate)
    "Sort dired listings with directories first before adding marks."
    (mydired-sort))
                                        ; Use Dired to attach files in mu4e
  (add-hook 'dired-mode-hook 'turn-on-gnus-dired-mode)
  (put 'dired-find-alternate-file 'disabled nil))

(use-package nerd-icons-dired
  :pin melpa
  :after (nerd-icons dired)
  :requires (nerd-icons dired)
  :after dired
  :hook (dired-mode . nerd-icons-dired-mode)
  :delight nerd-icons-dired-mode)

(use-package dired-hide-dotfiles
  :pin melpa
  :requires dired
  :after dired
  :hook (dired-mode . dired-hide-dotfiles-mode)
  :bind
  (:map dired-mode-map
        ("H" . dired-hide-dotfiles-mode))
  :delight dired-hide-dotfiles-mode)

(use-package dired-rsync
  :pin melpa
  :requires dired
  :after dired
  :bind
  (:map dired-mode-map
        ("r" . dired-rsync))
  :config
  (add-to-list 'mode-line-misc-info '(:eval dired-rsync-modeline-status 'append)))

(use-package image-dired
  :ensure nil
  :after dired
  :custom
  (image-dired-external-viewer "gimp"))

(use-package dired-open
  :after dired
  :custom
  (dired-open-extensions '(("png" . "sxiv")
                           ("PNG" . "sxiv")
                           ("jpeg" . "sxiv")
                           ("jpg" . "sxiv")
                           ("JPEG" . "sxiv")
                           ("JPG" . "sxiv"))))
