(use-package company
  :custom
  (company-idle-delay 0.1)
  (company-minimum-prefix-length 2)
  (company-global-modes '(java-mode org-mode c-mode))
  (company-lighter-base "CA")
  (company-format-margin-function #'company-text-icons-margin)
  (company-show-quick-access 'left)
  (company-backends '(company-etags
                      company-bbdb
                      company-semantic
                      company-capf
                      company-files
                      (company-dabbrev-code company-gtags company-keywords)
                      company-oddmuse
                      company-dabbrev))
  :config
  (progn
    (with-eval-after-load 'company
                                        ; for CLI
      (define-key company-active-map
        (kbd "TAB")
        #'company-complete-common-or-cycle)
                                        ; for GUI
      (define-key company-active-map
        (kbd "<tab>")
        #'company-complete-common-or-cycle)
      (define-key company-active-map
        (kbd "<backtab>")
        (lambda ()
          (interactive)
          (company-complete-common-or-cycle -1))))
    (global-company-mode)))
