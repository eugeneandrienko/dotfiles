(if (not (package-installed-p 'magit))
  (progn
     (package-refresh-contents)
     (package-install 'magit)))

(require 'magit)
