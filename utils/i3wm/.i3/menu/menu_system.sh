#!/usr/bin/env zsh

if [ -f /usr/bin/x11-ssh-askpass ]; then
    export SUDO_ASKPASS="/usr/bin/x11-ssh-askpass"
elif [ -f /usr/local/bin/x11-ssh-askpass ]; then
    export SUDO_ASKPASS="/usr/local/bin/x11-ssh-askpass"
else
    exit 1
fi

source ~/.bin/get_machine_id.sh
source ~/.i3/menu/menu_funcs.sh

ITEMS="display mode:redshift:poweroff:reboot"

case $(echo $ITEMS | parse_items | f_dmenu 'Select:') in
    'display mode')
        case $(echo "normal:threatre:night" | parse_items | f_dmenu '>') in
            'normal')
                if [ "$MACHINE_HW" != "thinkpad" ]; then
                    xset +dpms
                fi
                rm -f /tmp/nightmode.glsl*
                pkill picom
                picom -f --crop-shadow-to-monitor \
                      -I 0.08 -O 0.12 -D 20 \
                      --backend glx --force-win-blend \
                      --shadow-exclude 'class_g = "firefox"' \
                      --daemon
                notify-send -u low -t 5000 "Screen mode: NORMAL"
                ;;
            'theatre')
                xset -dpms
                notify-send -u low -t 5000 "Screen mode: THEATRE"
                ;;
            'night')
                NIGHT_SHADER=$(mktemp -p /tmp nightmode.glsl.XXX)
                cat << EOF > "$NIGHT_SHADER"
#version 330

in vec2 texcoord;
uniform sampler2D tex;
uniform float opacity;

vec4 default_post_processing(vec4 c);

vec4 window_shader() {
	vec2 texsize = textureSize(tex, 0);
	vec4 color = texture2D(tex, texcoord / texsize, 0);

	color = vec4(vec3(0.9 - color.r, 0.9 - color.g, 0.9 - color.b) * opacity, color.a * opacity);

	return default_post_processing(color);
}
EOF
                pkill picom
                picom -f --crop-shadow-to-monitor \
                      -I 0.08 -O 0.12 -D 20 \
                      --backend glx --force-win-blend \
                      --shadow-exclude 'class_g = "firefox"' \
                      --window-shader-fg "$NIGHT_SHADER" \
                      --daemon
                notify-send -u low -t 5000 "Screen mode: NIGHT"
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
        if [ "$MACHINE_OS" = "gentoo" ]; then
            sudo -A shutdown -hP now
        elif [ "$MACHINE_OS" = "freebsd" ]; then
            sudo -A shutdown -p now
        else
            sudo -A shutdown -h now
        fi
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
