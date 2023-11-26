#!/usr/bin/env zsh

if [ -f /usr/bin/x11-ssh-askpass ]; then
    export SUDO_ASKPASS="/usr/bin/x11-ssh-askpass"
else
    export SUDO_ASKPASS="/usr/bin/ssh-askpass"
fi

source ~/.bin/get_machine_id.sh
source ~/.i3/menu/menu_funcs.sh

if [ "$MACHINE_HW" = "thinkpad" ]; then
    ITEMS="display mode:redshift:cpufreq:poweroff:reboot"
else
    ITEMS="display mode:redshift:poweroff:reboot"
fi

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
    'cpufreq')
        case "$MACHINE_HW" in
            "zalman")
            ;;
            "thinkpad")
                PROMPT="Governor: "
                PROMPT+=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor)
                case $(echo "powersave:performance" | parse_items | f_dmenu "$PROMPT") in
                    "powersave")
                        sudo cpupower frequency-set -d 800MHz -u 1GHz -g powersave
                        sudo cpupower set -b 8
                        dunstify -u low "Powersave mode enabled"
                    ;;
                    "performance")
                        sudo cpupower frequency-set -d 800MHz -u 3.4GHz -g performance
                        sudo cpupower set -b 6
                        dunstify -u low "Performance mode enabled"
                    ;;
                esac
            ;;
        esac
        ;;
    *)
        exit 2
        ;;
esac
