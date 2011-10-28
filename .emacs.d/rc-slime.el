(add-to-list 'load-path "~/.emacs.d/elisp/slime/")
(require 'slime)
(slime-setup '(slime-repl))

(setq slime-net-coding-system 'utf-8-unix)
(setq slime-protocol-version 'ignore)
