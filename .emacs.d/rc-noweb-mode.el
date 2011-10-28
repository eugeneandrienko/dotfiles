(setq load-path (cons "~/.emacs.d/elisp/noweb-mode/" load-path))
(autoload 'noweb-mode "noweb-mode" "Editing noweb files." t)
(setq auto-mode-alist (cons '("\\.nw?\\'" . noweb-mode) auto-mode-alist))

;; (require 'noweb-font-lock-mode)

(defun my-newline-and-indent () 
  "Newline and indent that works better with noweb mode"
  (interactive "*")
  (if (and (boundp 'noweb-mode) noweb-mode)
      (save-restriction
        (noweb-update-chunk-vector)
        (noweb-narrow-to-chunk)
        (newline-and-indent))
    (newline-and-indent)))

(defun my-tab-key () 
  "Tab that always tabs in Fundamental mode" (interactive)
  (if (string= "Fundamental" mode-name)
      (insert "\t")
    (if (and (boundp 'noweb-mode) noweb-mode)
        (save-restriction
          (noweb-update-chunk-vector)
          (noweb-narrow-to-chunk)
          (indent-for-tab-command))
      (indent-for-tab-command))))

(defun use-my-indent-keys ()
  "Locally bind tab and ^J to keys that indent better" (interactive)
  (local-set-key "\t" 'my-tab-key)
  (local-set-key "\C-j" 'my-newline-and-indent))

(add-hook 'noweb-select-code-mode-hook 'use-my-indent-keys)

;;  ;;; We need this variable since we will be overwriting the
;;  ;;; noweb-code-mode from time to time.
;; (defvar my-noweb-main-code-mode nil
;;   "Variable used to save the default noweb-code-mode.")

;; (defun my-set-noweb-code-mode (beg-pt end-pt)
;;   "Set the noweb-code-mode for the chunk between BEG-PT and END-PT."
;;   (let (beg end done mode)
;;     ;; Reset code-mode to default and then check for a mode comment.
;;     (setq mode my-noweb-main-code-mode)
;;     (save-excursion
;;       (goto-char beg-pt)
;;       (beginning-of-line 2)
;;       (and (search-forward "-*-"
;;                            (save-excursion (end-of-line) (point))
;;                            t)
;;            (progn
;;              (skip-chars-forward " \t")
;;              (setq beg (point))
;;              (search-forward "-*-"
;;                              (save-excursion (end-of-line) (point))
;;                              t))
;;            (progn
;;              (forward-char -3)
;;              (skip-chars-backward " \t")
;;              (setq end (point))
;;              (goto-char beg)
;;              (setq mode (intern
;;                          (concat
;;                           (downcase (buffer-substring beg end))
;;                           "-mode")))))
;;       (noweb-set-code-mode mode))))

;; (defun my-noweb-pre-select-code-mode-hook ()
;;   "Set the code mode for the current chunk."
;;   (let ((r (noweb-chunk-region)))
;;     (my-set-noweb-code-mode (car r) (cdr r))
;;     t))

;; (defun my-noweb-select-mode-hook ()
;;   "Fontify the current chunk based on the chunks mode."
;;   ;; If this is the first time, save the default noweb-code-mode.
;;   (if my-noweb-first-time
;;       (progn
;;         (setq my-noweb-first-time nil)
;;         (setq my-noweb-main-code-mode noweb-code-mode)))
;;   (font-lock-set-defaults)
;;   (let ((r (noweb-chunk-region)))
;;     (save-excursion
;;       (font-lock-fontify-region (car r) (cdr r))
;;       t)))

;; (defun my-noweb-mode-hook()
;;   (setq my-noweb-first-time t))

;; (add-hook 'noweb-mode-hook 'my-noweb-mode-hook)
;; (add-hook 'noweb-select-mode-hook 'my-noweb-select-mode-hook)
;; (add-hook 'noweb-pre-select-code-mode-hook 'my-noweb-pre-select-code-mode-hook)
