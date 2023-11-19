(use-package sql-indent
  :config
  (progn
    (add-hook 'sql-mode-hook 'sqlind-minor-mode)
    (defun sqlind-set-my-offset()
      "Setup my offset"
      (setq sqlind-basic-offset 4))
    (add-hook 'sql-mode-hook 'sqlind-set-my-offset)))

(setq sql-product 'postgres)
