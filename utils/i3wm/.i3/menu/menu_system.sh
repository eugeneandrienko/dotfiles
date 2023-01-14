#!/usr/bin/env zsh

source ~/.bin/get_machine_id.sh

FONT="'-xos4-terminus-*-*-*-*-14-*-*-*-*-*-*-u'"
COLORS="-sb '#000000' -sf '#ffffff' -nb '#ffffff' -nf '#000000'"
DMENU_CMD="dmenu -i -b -fn $FONT $COLORS"

MODES_ITEMS="display mode:redshift:reboot"
case $(echo $MODES_ITEMS | tr ':' '\n' | eval "$DMENU_CMD -p Select:") in
    'display mode')
        case $(echo "normal:threatre" | tr ':' '\n' | eval "$DMENU_CMD -p '>'") in
            'normal')
                xset +dpms
                notify-send -u normal -t 5000 "Screen mode: NORMAL"
                ;;
            'theatre')
                xset -dpms
                notify-send -u normal -t 5000 "Screen mode: THEATRE"
                ;;
        esac
        ;;
    'redshift')
        case $(echo "on:off" | tr ':' '\n' | eval "$DMENU_CMD -p '>'") in
            'on')
                ~/.bin/redshift.sh
                ;;
            'off')
                pkill redshift
                ;;
        esac
        ;;
    'reboot')
        export SUDO_ASKPASS="/usr/bin/x11-ssh-askpass"
        case "$MACHINE_HW" in
            "zalman")
                REBOOT_ITEMS="windows:linux"
                ;;
            "thinkpad")
                REBOOT_ITEMS="linux"
                ;;
        esac
        case $(echo $REBOOT_ITEMS | tr ':' '\n' | eval "$DMENU_CMD -p '>'") in
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
    *)
        exit 2
        ;;
esac
