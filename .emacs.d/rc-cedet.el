(setq byte-compile-warnings nil)

(load-file "~/.emacs.d/elisp/cedet/common/cedet.el")

(global-ede-mode 1)
(semantic-load-enable-code-helpers)
(semantic-load-enable-gaudy-code-helpers)
(semantic-load-enable-primary-exuberent-ctags-support)
