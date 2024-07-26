(use-package vertico
  :custom
  (vertico-cycle t)
  :init
  (vertico-mode)
  :config
  (progn
    ;; Fixes for OrgMode:
    (advice-add #'org-make-tags-matcher :around #'vertico-enforce-basic-completion)
    (advice-add #'org-agenda-filter :around #'vertico-enforce-basic-completion)
    (setq org-refile-use-outline-path 'file
          org-outline-path-complete-in-steps nil)))

(use-package savehist
  :init
  (savehist-mode))

(use-package emacs
  :custom
  (enable-recursive-minibuffers t)
  ;; Emacs 28 and newer: Hide commands in M-x which do not work in the current
  ;; mode.  Vertico commands are hidden in normal buffers. This setting is
  ;; useful beyond Vertico.
  (read-extended-command-predicate #'command-completion-default-include-p)
  :init
    ;; Add prompt indicator to `completing-read-multiple'.
  ;; We display [CRM<separator>], e.g., [CRM,] if the separator is a comma.
  (defun crm-indicator (args)
    (cons (format "[CRM%s] %s"
                  (replace-regexp-in-string
                   "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" ""
                   crm-separator)
                  (car args))
          (cdr args)))
  (advice-add #'completing-read-multiple :filter-args #'crm-indicator)

  ;; Do not allow the cursor in the minibuffer prompt
  (setq minibuffer-prompt-properties
        '(read-only t cursor-intangible t face minibuffer-prompt))
  (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode))

(use-package orderless
  :custom
  (completion-styles '(substring orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))
