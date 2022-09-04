(use-package auto-complete-config
  :ensure auto-complete
  :config
  (progn (ac-config-default)
	 (ac-flyspell-workaround))
  :hook
  ((c-mode-common-hook . (lambda ()
			   (add-to-list 'ac-omni-completion-sources
					(cons "\\." '(ac-source-semantic)))
			   (add-to-list 'ac-omni-completion-sources
					(cons "->" '(ac-source-semantic)))
			   (setq ac-sources '(ac-source-semantic))))))

