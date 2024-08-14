(use-package sql-indent
  :pin gnu
  :disabled
  :custom
  (sql-product 'postgres "Default SQL dialect")
  :config
  (add-hook 'sql-mode-hook 'sqlind-minor-mode)
  (defun sqlind-set-my-offset()
    "Setup my offset"
    (setq sqlind-basic-offset 4))
  (add-hook 'sql-mode-hook 'sqlind-set-my-offset))
