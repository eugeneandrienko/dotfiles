#!/usr/bin/env zsh

if [ -f /usr/bin/x11-ssh-askpass ]; then
    export SUDO_ASKPASS="/usr/bin/x11-ssh-askpass"
else
    export SUDO_ASKPASS="/usr/bin/ssh-askpass"
fi

source ~/.bin/get_machine_id.sh
source ~/.i3/menu/menu_funcs.sh

ITEMS="display mode:redshift:poweroff:reboot"
case $(echo $ITEMS | parse_items | f_dmenu 'Select:') in
    'display mode')
        case $(echo "normal:threatre" | parse_items | f_dmenu '>') in
            'normal')
                xset +dpms
                notify-send -u low -t 5000 "Screen mode: NORMAL"
                ;;
            'theatre')
                xset -dpms
                notify-send -u low -t 5000 "Screen mode: THEATRE"
                ;;
        esac
        ;;
    'redshift')
        PROMPT="State: "
        if pgrep -x "redshift" > /dev/null; then
            PROMPT+="on"
        else
            PROMPT+="off"
        fi
        PROMPT+=""
        case $(echo "on:off" | parse_items | f_dmenu "$PROMPT") in
            'on')
                ~/.bin/redshift.sh
                dunstify -u low "Redshift enabled"
                ;;
            'off')
                pkill redshift
                dunstify -u low "Redshift disabled"
                ;;
        esac
        ;;
    'poweroff')
        sudo -A shutdown -hP now
        i3-msg exit
        ;;
    'reboot')
        case "$MACHINE_HW" in
            "zalman")
                case $(echo "windows:linux" | parse_items | f_dmenu '>') in
                    'windows')
                        sudo -A touch /root/REBOOT.reboot
                        sudo -A grub-reboot 'Windows 10 (on /dev/sda1)'
                        i3-msg exit
                        ;;
                    'linux')
                        sudo -A touch /root/REBOOT.reboot
                        i3-msg exit
                        ;;
                esac
                ;;
            "thinkpad")
                sudo -A shutdown -r now
                ;;
        esac
        ;;
    *)
        exit 2
        ;;
esac
