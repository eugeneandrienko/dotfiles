(install-missing-package 'clojure-mode)
(install-missing-package 'highlight-symbol)
(install-missing-package 'cider)

(require 'clojure-mode)
(require 'highlight-symbol)
(require 'cider)
(setq highlight-symbol-idle-delay 1)

(defun my-clojure-mode-hook ()
  (hs-minor-mode 1)
  (paredit-mode 1)
  (highlight-symbol-mode)
  (setq highlight-symbol-face '((:underline t)))
  (local-set-key (kbd "C-c p") 'slime-eval-print-last-expression)
  (local-set-key (kbd "C-c d") 'highlight-symbol-at-point)
  (custom-set-faces '(highlight-symbol-face ((((class color) (background dark)) (:background "OliveDrab")))))
  (font-lock-add-keywords
   'clojure-mode `(("(\\(fn\\>\\)"
                    (0 (progn (compose-region (match-beginning 1)
                                              (match-end 1) "ƒ")
                              nil))))))

(add-hook 'clojure-mode-hook 'my-clojure-mode-hook)
(set-language-environment "UTF-8")

(setq inferior-lisp-program "lein repl")

; Disable warning when jacking-in outside a project
(setq cider-allow-jack-in-without-project t)
