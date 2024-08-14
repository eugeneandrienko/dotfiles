(use-package langtool
  :pin melpa
  :init
  (setq langtool-language-tool-jar
        "~/bin/languagetool/languagetool-commandline.jar")
  :bind
  ([f12] . langtool-check-buffer)
  :custom
  (langtool-default-language "ru-RU")
  (langtool-mother-tongue "ru")
  (langtool-java-user-arguments '("-Dfile.encoding=UTF-8")))

(use-package langtool-popup
  :pin melpa
  :requires langtool
  :after langtool)
