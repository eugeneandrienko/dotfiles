;; WikiCreole mode (wiki-mode)
;; Thanks to Alex Schroeder of www.emacswiki.org 
;; And Jason Blevins for his inspiring Markdown Mode
;; http://jblevins.org/projects/markdown-mode/
(define-generic-mode 'wiki-mode 
  nil ; comments 
  nil; keywords 
  '(("^\\(= \\)\\(.*?\\)\\($\\| =$\\)" . 'info-title-1)
    ("^\\(== \\)\\(.*?\\)\\($\\| ==$\\)" . 'info-title-2)
    ("^\\(=== \\)\\(.*?\\)\\($\\| ===$\\)" . 'info-title-3)
    ("^\\(====+ \\)\\(.*?\\)\\($\\| ====+$\\)" . 'info-title-4) 
    ("\\[\\[.*?\\]\\]" . 'link)
    ("\\[.*\\]" . 'link)
    ("\\[b\\].*?\\[/b\\]" . 'bold)
    ("\\[i\\].*?\\[/i\\]" . 'italic)
    ("\\*\\*.*?\\*\\*" . 'bold)
    ("\\*.*?\\*" . 'bold)
    ("\\_<//.*?//" . 'italic)
    ("\\_</.*?/" . 'italic)
    ("__.*?__" . 'italic)
    ("_.*?_" . 'underline)
    ("|+=?" . font-lock-string-face)
    ("\\\\\\\\[ \t]+" . font-lock-warning-face)) ; font-lock list
  '(".wiki\\'"); auto-mode-alist
  '((lambda () (require 'info) (require 'goto-addr))); function-list
  "Wiki stuff including Creole Markup and BBCode.")
