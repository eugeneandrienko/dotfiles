(if (not (package-installed-p 'elein))
  (progn
     (package-refresh-contents)
     (package-install 'elein)))

(require 'elein)
