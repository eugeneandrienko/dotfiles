(use-package password-store
  :ensure t)

(use-package password-store-otp
  :ensure t
  :after password-store)

(use-package pass
  :ensure t
  :after password-store-otp
  :custom
  (pass-username-fallback-on-filename t))
