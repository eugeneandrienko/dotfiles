;;;this file must be executed after rc-emacs.el !

(add-hook 'c-mode-hook 'my-ret-hook)
(add-hook 'c-mode-hook
	  '(lambda ()
	     (linum-mode 1)))
(add-hook 'c-mode-hook 'fci-mode)
;enable FIXME:|TODO:|BUG: highlighting for C source code
(add-hook 'c-mode-common-hook
	  (lambda ()
	    (font-lock-add-keywords 
	     nil
	     '(("\\<\\(FIXME\\|TODO\\|BUG\\):" 1 font-lock-warning-face t)))))
;; indent
;; switch (c) {
;;  case 0:
;;   exit();
;;   break;
;;  default:
;;   return;
;; }
;; unstead of
;; switch (c) {
;; case 0:
;;  exit();
;;  break;
;; default:
;;  return;
;; }
(add-hook 'c-mode-common-hook
          (lambda ()
	    (c-set-offset 'case-label 2)))
;;for linux coding style
(defun c-lineup-arglist-tabs-only (ignored)
  "Line up argument lists by tabs, not spaces"
  (let* ((anchor (c-langelem-pos c-syntactic-element))
	 (column (c-langelem-2nd-pos c-syntactic-element))
	 (offset (- (1+ column) anchor))
	 (steps (floor offset c-basic-offset)))
    (* (max steps 1)
       c-basic-offset)))

;; (add-hook 'c-mode-common-hook
;;           (lambda ()
;;             ;; Add kernel style
;;             (c-add-style
;;              "linux-tabs-only"
;;              '("linux" (c-offsets-alist
;;                         (arglist-cont-nonempty
;;                          c-lineup-gcc-asm-reg
;;                          c-lineup-arglist-tabs-only))))))
(add-hook 'c-mode-common-hook
	  (lambda ()
;	    (c-set-style "linux-tabs-only")
	    (c-set-style "K&R")
	    (setq tab-width 2)
	    (setq indent-tabs-mode t)
	    (setq c-basic-offset 2)))
