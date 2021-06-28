if [ -f ~/.freebsd-thinkpad ]; then
    if ! pefs mount | grep -q '/secure'; then
        rm -rfv "$HOME/secure/.emacs.d/"
        rm -fv "$HOME/secure/.netrc"
        rm -fv "$HOME/secure/.viminfo"
        rm -rfv "$HOME/secure/.vim/"
        rm -fv "$HOME/secure/.zsh_history"
    fi
fi

