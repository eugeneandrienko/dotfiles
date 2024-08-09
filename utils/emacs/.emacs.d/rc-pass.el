(use-package password-store)

(use-package password-store-otp
  :after password-store)

(use-package pass
  :after password-store-otp
  :custom
  (pass-username-fallback-on-filename t))
