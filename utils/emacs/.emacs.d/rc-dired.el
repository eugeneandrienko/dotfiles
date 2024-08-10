(use-package dired
  :ensure nil
  :custom
  (dired-listing-switches "-lah")
  (dired-kill-when-opening-new-dired-buffer t "Only one Dired buffer")
  (image-dired-thumb-margin 5)
  (dired-dwim-target t "Suggest already opened Dired buffers for file operations")
  (dired-recursive-copies 'always)
  (dired-recursive-deletes 'always)
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
                                       "qmapshack * ")))
  (wdired-allow-to-change-permissions t)
  (dired-mouse-drag-files t "Enable mouse dragging to another apps")
  :config
  (progn
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
      (mydired-sort))))

(use-package all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode))

(use-package dired-hide-dotfiles
  :hook (dired-mode . dired-hide-dotfiles-mode)
  :bind
  (:map dired-mode-map
        ("H" . dired-hide-dotfiles-mode)))

(use-package dired-rsync
  :demand t
  :after dired
  :bind
  (:map dired-mode-map
        ("r" . dired-rsync))
  :config
  (add-to-list 'mode-line-misc-info '(:eval dired-rsync-modeline-status 'append)))
