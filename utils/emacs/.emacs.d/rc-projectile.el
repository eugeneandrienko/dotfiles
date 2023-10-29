(use-package projectile
  :init
  (projectile-mode +1)
  :config
  (progn
    (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
    (setq projectile-mode-line-function '(lambda ()
                                          (if (string= "-" (projectile-project-name))
                                              (progn "")
                                            (format " Proj[%s]" (projectile-project-name)))))))
