(use-package projectile
  :config
  (progn (projectile-mode +1)
         (recentf-mode 1))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :custom
  (recentf-max-menu-items 10)
  (recentf-max-saved-items 20)
  (projectile-sort-order 'recently-active)
  ;; Hide projectile mode line
  (projectile-mode-line-prefix "")
  (projectile-dynamic-mode-line nil))

(use-package flycheck)

(use-package lsp-mode)

(use-package company
  :config
  (progn (with-eval-after-load 'company
           (define-key company-active-map
             (kbd "TAB")
             #'company-complete-common-or-cycle)
           (define-key company-active-map
             (kbd "<backtab>")
             (lambda ()
               (interactive)
               (company-complete-common-or-cycle -1)))))
  :custom
  (company-global-modes '(java-mode lsp-mode))
  (company-idle-delay 0)
  ;; Hide company mode line
  (company-lighter-base ""))

(use-package lsp-ui
  :custom
  (lsp-ui-doc-enable t)
  (lsp-ui-doc-position 'at-point)
  (lsp-ui-doc-delay 0)
  :bind
  ("C-c s d" . lsp-ui-doc-show)
  ("C-c s h" . lsp-ui-doc-hide))

(use-package lsp-java-lombok
  :load-path "~/.emacs.d/plugins/"
  :ensure  nil
  :custom
  (lsp-java-lombok/enabled t)
  :config
  (lsp-java-lombok/init))

(use-package lsp-java
  :after
  (lsp-java-lombok)
  :config
  (progn
    (add-hook 'java-mode-hook 'lsp)
    (cond ((file-directory-p "/usr/lib/jvm/java-17-openjdk-amd64/")
           (setenv "JAVA_HOME" "/usr/lib/jvm/java-17-openjdk-amd64/"))))
  :custom
  (lsp-enable-snippet nil)
  (lsp-java-configuration-check-project-settings-exclusions t)
  (lsp-java-references-code-lens-enabled t)
  (lsp-java-signature-help-enabled t)
  (lsp-java-implementations-code-lens-enabled t)
  (lsp-java-save-actions-organize-imports t)
  (lsp-java-autobuild-enabled nil)
  (lsp-java-format-comments-enabled t)
  (lsp-java-format-on-type-enabled t)
  (lsp-java-code-generation-use-blocks t)
  (lsp-java-code-generation-generate-comments t))

;;(use-package dap-mode
;;  :after
;;  lsp-mode
;;  :config
;;  (dap-auto-configure-mode))
;;
;;(use-package dap-java
;;  :ensure nil
;;  :after
;;  dap-mode)

(use-package treemacs
  :custom
  (treemacs-display-current-project-exclusively t)
  (treemacs-project-follow-mode t)
  (treemacs-git-commit-diff-mode t)
  (treemacs-no-png-images t)
  (treemacs-follow-after-init t)
  (treemacs-expand-after-init t)
  :config
  (progn
    (treemacs-git-mode 'extended)
    (treemacs-hide-gitignored-files-mode t)
    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t))
  :bind
  ("C-c t t" . treemacs))

(use-package treemacs-projectile
  :after
  (projectile treemacs))

(use-package lsp-treemacs
  :config
  (lsp-treemacs-sync-mode 1)
  :bind
  ("C-c t s" . lsp-treemacs-symbols))
