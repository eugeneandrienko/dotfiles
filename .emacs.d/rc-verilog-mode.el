(add-to-list 'load-path "~/.emacs.d/elisp/verilog-mode/")

(autoload 'verilog-mode "verilog-mode" "Verilog mode" t )
(add-to-list 'auto-mode-alist '("\\.[ds]?vh?\\'" . verilog-mode))

(setq verilog-auto-indent-on-newline t
      verilog-tab-always-indent t
      verilog-auto-end-comments t
      verilog-linter "iverilog"
      verilog-auto-lineup 'assignment
      verilog-auto-newline nil
      )
