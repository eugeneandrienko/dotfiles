(setq load-path (cons "~/.emacs.d/elisp/android/" load-path))

(require 'android)
(require 'android-mode)

(setq android-mode-sdk-dir "~/tools/android-sdk-linux")
(add-hook 'gud-mode-hook
	  (lambda ()
            (add-to-list 'gud-jdb-classpath "/home/drag0n/tools/android-sdk-linux/platforms/android-10/android.jar")))
