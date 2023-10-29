(use-package lsp-mode
  :config
  (progn
    (define-key lsp-mode-map (kbd "C-c j") lsp-command-map))
  :init
  (setq lsp-keymap-prefix "C-c j")
  :hook
  (lsp-mode . lsp-enable-which-key-integration)
  (java-mode . #'lsp-deferred)
  :config
  (setq lsp-intelephense-multi-root nil) ; don't scan unnecessary projects
  (with-eval-after-load 'lsp-intelephense
    (setf (lsp--client-multi-root (gethash 'iph lsp-clients)) nil))
  (define-key lsp-mode-map (kbd "C-c l") lsp-command-map))

(use-package lsp-treemacs
  :commands lsp-treemacs-errors-list
  :init (lsp-treemacs-sync-mode 1))

;; Guide — how to configure some of lsp-mode features
;; https://emacs-lsp.github.io/lsp-mode/tutorials/how-to-turn-off/
(use-package lsp-ui
  :custom
  (lsp-ui-doc-enable t)
  (lsp-ui-doc-delay 1.5)
  (lsp-ui-doc-position 'bottom)
  (lsp-ui-doc-max-width 100)
  (lsp-ui-doc-show-with-mouse nil)
  (lsp-ui-doc-show-with-cursor t)
  (lsp-ui-doc-use-childframe t)
  (lsp-ui-imenu-auto-refresh t)
  (lsp-headerline-breadcrumb-enable nil)
  (lsp-modeline-code-actions-enable nil)
  :bind (:map lsp-mode-map
              ("M-2" . lsp-ui-imenu)
              ("M-3" . lsp-ui-flycheck-list)
              ("<f2>" . flycheck-next-error)
              ("S-<f2>" . flycheck-previous-error)))

(use-package lsp-java
  :config
  (progn
    (add-hook 'java-mode-hook #'lsp)
    (defun setup-lombok()
      "Setup Lombok with lsp-java"
      (setq lombok-library-path (concat "~/.emacs.d/" "lombok.jar"))
      (unless (file-exists-p lombok-library-path)
        (url-copy-file "https://projectlombok.org/downloads/lombok.jar" lombok-library-path))
      (setq lsp-java-vmargs '("-XX:+UseParallelGC"
                              "-XX:GCTimeRatio=4"
                              "-XX:AdaptiveSizePolicyWeight=90"
                              "-Dsun.zip.disableMemoryMapping=true"
                              "-Xmx4G"
                              "-Xms100m"))
      (push (concat "-javaagent:"
                    (expand-file-name lombok-library-path))
            lsp-java-vmargs))
    (setup-lombok)))

;; Debugging
(use-package dap-mode
  :after (lsp-mode)
  :functions dap-hydra/nil
  :config
  (require 'dap-java)
  :bind (:map lsp-mode-map
              ("<f5>" . dap-debug)
              ("M-<f5>" . dap-hydra))
  :hook ((dap-mode . dap-ui-mode)
         (dap-session-created . (lambda (&_rest) (dap-hydra)))
         (dap-terminated . (lambda (&_rest) (dap-hydra/nil)))))

(use-package dap-java
  :ensure nil)
