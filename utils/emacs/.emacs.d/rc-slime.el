(if (not (package-installed-p 'slime))
  (progn
     (package-refresh-contents)
     (package-install 'slime)))

(require 'slime)
(slime-setup '(slime-repl))

(setq slime-net-coding-system 'utf-8-unix)
(setq slime-protocol-version 'ignore)
