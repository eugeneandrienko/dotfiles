(use-package company
  :delight
  :pin melpa
  :custom
  (company-idle-delay 0.1 "Delay before show completions")
  (company-minimum-prefix-length 2 "Characters to start completion")
  (company-global-modes '(java-mode c-mode) "Modes with enabled completion")
  (company-format-margin-function #'company-text-icons-margin "Use text-icons with completion results")
  (company-show-quick-access 'left "Show quick access hints")
  (company-backends '(company-etags
                      company-bbdb
                      company-semantic
                      company-capf
                      company-files
                      (company-dabbrev-code company-gtags company-keywords)
                      company-oddmuse
                      company-dabbrev)
                    "Enabled backends")
  :config
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
  (global-company-mode))
