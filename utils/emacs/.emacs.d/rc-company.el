(use-package company
  :delight
  :pin melpa
  :bind
  (:map company-active-map
        ("TAB" . 'company-complete-common-or-cycle)
        ("<tab>" . 'company-complete-common-or-cycle)
        ("<backtab>" . (lambda ()
                         (interactive)
                         (company-complete-common-or-cycle -1))))
  :custom
  (company-idle-delay 0.2 "Delay before show completions")
  (company-minimum-prefix-length 3 "Characters to start completion")
  (company-tooltip-align-annotations t "Right align additional annotations")
  (company-inhibit-inside-symbols t "Disable completion in the middle of string")
  (company-global-modes '(java-mode
                          c-mode
                          emacs-lisp-mode)
                        "Modes with enabled completion")
  (company-format-margin-function #'company-text-icons-margin "Use text-icons with completion results")
  (company-show-quick-access 'left "Show quick access hints")
  (company-transformers '(delete-consecutive-dups company-sort-by-occurrence)
                        "Filters for completion results")
  :config
  (global-company-mode))

(use-package company-ctags
  :delight
  :pin melpa
  :after company
  :custom
  (company-ctags-fuzzy-match-p t "Enable fuzzy matching")
  (company-ctags-tags-file-name "TAGS" "ctags file name")
  (company-ctags-extra-tags-files '("$HOME/git_repos/palm-sync-daemon/TAGS"))
  (company-backends '((company-ctags company-capf company-semantic)
                      company-keywords)
                    "Enabled backends")
  :config
  (company-ctags-auto-setup))
