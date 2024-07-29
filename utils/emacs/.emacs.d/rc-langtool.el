(use-package langtool
  :init
  (setq langtool-language-tool-jar
        "~/bin/languagetool/languagetool-commandline.jar")
  :custom
  (langtool-default-language "ru-RU")
  (langtool-mother-tongue "ru")
  (langtool-java-user-arguments '("-Dfile.encoding=UTF-8"))
  :config
  (global-set-key [f12] (lambda ()
                          (interactive)
                          (langtool-check-buffer))))

(use-package langtool-popup
  :after langtool)
