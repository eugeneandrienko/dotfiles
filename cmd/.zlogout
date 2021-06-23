if [ -f ~/.freebsd-thinkpad ]; then
    if ! pefs mount | grep -q '/secure'; then
        rm -fv "$HOME/secure/.zsh_history"
        rm -fv "$HOME/secure/.viminfo"
    fi
fi

