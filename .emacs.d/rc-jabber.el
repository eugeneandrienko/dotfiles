(setq load-path (cons "~/.emacs.d/elisp/jabber" load-path))
(require 'jabber-autoloads)
(when (require 'jabber nil t)
        (setq jabber-history-enabled t
              jabber-use-global-history nil
              jabber-auto-reconnect t
              jabber-avatar-cache-directory "~/.emacs.d/elisp/jabber/avatars/"
              jabber-avatar-verbose nil
              jabber-chat-buffer-show-avatar nil
              jabber-default-status "Online"
              jabber-history-dir "~/.emacs.d/elisp/jabber/history/"
              jabber-history-size-limit 8192
              jabber-reconnect-delay 3
              jabber-roster-buffer "*-jabber-roster-*"
              jabber-show-offline-contacts nil
              jabber-nickname "h0rr0rr_drag0n"
              jabber-whitespace-ping-interval 3
              jabber-roster-line-format " %c %-25n %u %-8s  %S"
              jabber-groupchat-buffer-format "*-jg-%n-*"
              jabber-roster-buffer "*-jroster-*"
              jabber-chat-buffer-format "*-jc-%n-*"
              jabber-account-list (quote (("h0rr0rrdrag0n@jabber.ru/Emacs" 
                                          (:network-server . "ssl.jabber.ru") 
                                          (:port . 443) 
                                          (:connection-type . ssl))))))
;Switch off help in roster
(jabber-roster-toggle-binding-display)
