(setq-default ispell-program-name "aspell")
(setq ispell-list-command "list")
(setq ispell-local-dictionary "ru")
(setq flyspell-dictionary "ru")
(setq ispell-extra-args '("--sug-mode=ultra"))
(global-set-key [f12] 'flyspell-mode)

