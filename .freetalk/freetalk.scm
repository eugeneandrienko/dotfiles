(ft-set-jid! "h0rr0rr_drag0n@jabbim.com")
(ft-set-server! "jabbim.com")
(ft-set-sslconn! #t)
(ft-set-proxy! #f)
(ft-set-port! 5223)
(add-hook! ft-login-hook
           (lambda (status)
             (if status
                 (begin
                   (ft-set-prompt! "~\\/~ ")
                   (ft-set-status-msg! "chat I use GNU Freetalk")))))
;;;
;;; Let ctrl-a display full roster, ctrl-e who i am, ctrl-h online buddies
(ft-bind-to-ctrl-key #\a "(/who \"all\")")
; (ft-bind-to-ctrl-key #\e "(/whoami \"\")")
(ft-bind-to-ctrl-key #\h "(/who \"\")")
