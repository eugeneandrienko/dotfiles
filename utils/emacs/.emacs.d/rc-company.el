(use-package company
  :custom
  (company-idle-delay 0.2)
  (company-global-modes '(java-mode org-mode))
  (company-lighter-base "CA")
  (company-format-margin-function #'company-text-icons-margin)
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
