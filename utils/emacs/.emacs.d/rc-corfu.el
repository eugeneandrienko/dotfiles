(use-package corfu
  :delight
  :pin melpa
  :custom
  (corfu-cycle t "Cycling for next/previous")
  (corfu-auto t "Auto completion")
  (corfu-bar-width 0.5)
  (corfu-count 7 "Maximal number of candidated to show")
  (text-mode-ispell-word-completion nil "Disable ispell completion")
  (corfu-quit-no-match 'separator "Quit if no match or only separator is shown")
  (corfu-separator ?\s "Orderless file separator")
  (corfu-preselect 'prompt "Preselect prompt")
  :config
  (global-corfu-mode))

(use-package corfu-popupinfo
  :ensure nil
  :after corfu
  :hook (corfu-mode . corfu-popupinfo-mode)
  :custom
  (corfu-popupinfo-delay '(0.25 . 0.1))
  (corfu-popupinfo-hide nil))

(use-package cape
  :delight
  :pin melpa
  :after corfu
  :config
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-history)
  (add-hook 'completion-at-point-functions #'cape-elisp-block)
  (add-hook 'completion-at-point-functions #'cape-elisp-symbol))

(use-package nerd-icons-corfu
  :requires nerd-icons
  :init
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter)
  :config
  (setq nerd-icons-corfu-mapping
        '((array :style "cod" :icon "symbol_array" :face font-lock-type-face)
          (boolean :style "cod" :icon "symbol_boolean" :face font-lock-builtin-face)
          (t :style "cod" :icon "code" :face font-lock-warning-face))))
