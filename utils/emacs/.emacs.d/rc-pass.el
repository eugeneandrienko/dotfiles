(use-package password-store
  :pin melpa)
(use-package password-store-otp
  :pin melpa
  :requires password-store
  :after password-store)
(use-package pass
  :pin melpa
  :requires (password-store password-store-otp)
  :after (password-store password-store-otp)
  :custom
  (pass-username-fallback-on-filename t "Take username from filename if no entry in file itself")
  (pass-suppress-confirmations t "Don't ask for confirmations"))
