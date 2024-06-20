;; Linux style for C code formatting
;; And 1 Tab = 4 Spaces
(setq c-default-style "linux"
      c-basic-offset 4)

(setq c-doc-comment-style '(
                            (java-mode . javadoc)
                            (pike-mode . autodoc)
                            (c-mode . doxygen)))
