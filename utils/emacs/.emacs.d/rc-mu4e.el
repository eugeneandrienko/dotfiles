(use-package smtpmail
  :ensure nil)

(use-package mu4e
  :ensure nil
  :after smtpmail
  :commands (mu4e)
  :custom
  (mu4e-sent-folder "/sent")
  (mu4e-drafts-folder "/postponed")
  (mu4e-use-fancy-chars t "Use non-ASCII characters in interface")
  (mu4e-confirm-quit nil "Quit wout confirmation")
  (mu4e-attachment-dir "~/downloads" "Default path to store attachments")
  (mu4e-view-show-images t "Show images in e-mails")
  (mu4e-view-scroll-to-next nil "Do not open next message when scrolling to the end of the first one")
  (sendmail-program (executable-find "msmtp"))
  (message-sendmail-envelope-from 'header)
  (send-mail-function 'sendmail-send-it)
  (message-send-mail-function 'sendmail-send-it)
  (sendmail-coding-system 'utf-8)
  (message-generate-headers-first t "Generate all required headers before composing message")
  (message-kill-buffer-on-exit t "Don't keep message buffer after send")
  (mu4e-get-mail-command "~/.bin/get_mail.sh -pm")
  (mail-user-agent 'mu4e-user-agent "Use mu4e as default email client")
  (mu4e-compose-reply-to-address "evg.andrienko@gmail.com")
  (user-mail-address "evg.andrienko@gmail.com")
  (mu4e-user-mail-address-list '("h0rr0rrdrag@gmail.com"
                                 "evg.andrienko@gmail.com"))
  (mu4e-compose-format-flowed t "Use format=flowed to reflow paragraphs")
  (user-full-name "Eugene")
  (message-signature "Eugene Andrienko")
  (mu4e-bookmarks '((:name "Unread messages"
                           :query "flag:unread AND NOT flag:trashed"
                           :key 117)
                    (:name "Today's messages"
                           :query "date:today..now"
                           :key 116)))
  (mu4e-maildir-shortcuts '((:maildir "/banks" :key ?b)
                            (:maildir "/checks" :key ?c)
                            (:maildir "/default" :key ?d)
                            (:maildir "/expresso" :key ?e)
                            (:maildir "/infrastructure" :key ?i)
                            (:maildir "/maillists" :key ?a)
                            (:maildir "/osm" :key ?m)
                            (:maildir "/rss" :key ?r)
                            (:maildir "/rss-lobsters" :key ?l)
                            (:maildir "/rss-podcasts" :key ?p)
                            (:maildir "/rss-youtube" :key ?y)
                            (:maildir "/social" :key ?s)
                            (:maildir "/state" :key ?z)
                            (:maildir "/stores" :key ?t)))
  (mu4e-headers-fields '((:human-date . 12) (:flags . 6) (:from . 22) (:thread-subject)))
  :config
                                        ; Use mu4e as preferred method for reading e-mails
  (set-variable 'read-mail-command 'mu4e)
                                        ; Choose account before sending
  (defun drag0n/set-msmtp-account ()
    (if (message-mail-p)
        (save-excursion
          (let*
              ((from (save-restriction
                       (message-narrow-to-headers)
                       (message-fetch-field "from")))
               (account
                (cond
                 ((string-match "h0rr0rrdrag@gmail.com" from) "default")
                 ((string-match "evg.andrienko@gmail.com" from) "official"))))
            (setq message-sendmail-extra-arguments (list '"-a" account))))))
  (add-hook 'message-send-mail-hook 'drag0n/set-msmtp-account))
