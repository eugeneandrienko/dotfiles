(setq byte-compile-warnings nil)

(load-file "/usr/share/emacs/site-lisp/cedet/common/cedet.el")

(global-ede-mode 1)
(semantic-load-enable-code-helpers)
(semantic-load-enable-gaudy-code-helpers)

(semantic-load-enable-primary-exuberent-ctags-support)

(global-semantic-stickyfunc-mode nil)

(semantic-add-system-include "/usr/include" 'c-mode)
(require 'semantic-gcc)
