(use-package prodigy
  :pin melpa
  :config
  (prodigy-define-tag
    :name "vpn"
    :truncate-output 100)
  (prodigy-define-tag
    :name "work"
    :cwd "~/"
    :kill-process-buffer-on-stop t
    :truncate-output 50)
  (prodigy-define-service
    :name "v2rayA"
    :command "~/bin/v2raya/v2raya"
    :args `("--lite"
            "--address" "127.0.0.1:1984"
            "--v2ray-assetsdir" ,(concat "/home/" (user-login-name) "/.local/share/xray")
            "--config" ,(concat "/home/" (user-login-name) "/.config/v2raya"))
    :cwd "~/bin/v2raya"
    :tags '(vpn)
    :url "http://127.0.0.1:1984/"
    :kill-process-buffer-on-stop t
    :on-output (lambda (&rest args)
                 (let ((output (plist-get args :output))
                       (service (plist-get args :service)))
                   (when (string-match ".*A unified platform for anti-censorship\\..*" output)
                     (prodigy-set-status service 'ready))
                   (when (string-match ".*\\[EE\\].*" output)
                     (prodigy-set-status service 'failed)))))
  (prodigy-define-service
    :name "VPN to work"
    :command "~/work.sh"
    :tags '(work)
    :on-output (lambda (&rest args)
                 (let ((output (plist-get args :output))
                       (service (plist-get args :service)))
                   (when (string-match ".*Initialization Sequence Completed.*" output)
                     (prodigy-set-status service 'ready))
                   (when (string-match ".*process exiting.*" output)
                     (prodigy-set-status service 'stopped)))))
  (prodigy-define-service
   :name "Work VPN client"
   :command "~/work.sh"
   :tags '(work)))
