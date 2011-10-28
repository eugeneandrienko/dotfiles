(add-to-list 'load-path "~/.emacs.d/elisp/emms/")

(require 'emms-setup)
(require 'emms-player-simple)
(require 'emms-player-mplayer)
(require 'emms-source-file)
(require 'emms-source-playlist)
(require 'emms-volume)

(emms-standard)
(emms-default-players)
(setq emms-player-list '(emms-player-mplayer
                         emms-player-ogg123
                         emms-player-mpg321))
;When asked for emms-play-directory,
;always start from this one 
(setq emms-source-file-default-directory "~/music/")
(global-set-key "\e\eef" 'emms-add-file)
(global-set-key "\e\eed" 'emms-add-directory-tree)
(global-set-key "\e\eep" 'emms-pause)
(global-set-key "\e\eel" 'emms-playlist-mode-go)
(global-set-key "\e\ee-" 'emms-volume-mode-minus)
(global-set-key "\e\ee+" 'emms-volume-mode-plus)
