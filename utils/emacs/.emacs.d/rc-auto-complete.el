(use-package auto-complete-config
  :ensure auto-complete
  :config
  (progn (ac-config-default)
	 (ac-flyspell-workaround)
         (defun auto-complete-mode-maybe ()
           "No maybe for java-mode"
           (unless (eq major-mode 'java-mode)
             (auto-complete-mode 1))))
  :hook
  ((c-mode-common-hook . (lambda ()
			   (add-to-list 'ac-omni-completion-sources
					(cons "\\." '(ac-source-semantic)))
			   (add-to-list 'ac-omni-completion-sources
					(cons "->" '(ac-source-semantic)))
			   (setq ac-sources '(ac-source-semantic)))))
  :custom
  (ac-ignore-case 'smart' "Ignore case if string not include upper characters"))
