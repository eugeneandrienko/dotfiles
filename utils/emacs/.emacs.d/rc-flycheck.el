(use-package flycheck
  :hook
  (java-mode-hook . flycheck-mode)
  :custom
  (flycheck-mode-line nil)
  :config
  (progn
    (add-to-list 'display-buffer-alist
                 `(,(rx bos "*Flycheck errors*" eos)
                   (display-buffer-reuse-window
                    display-buffer-in-side-window)
                   (side            . bottom)
                   (reusable-frames . visible)
                   (window-height   . 0.33)))))
