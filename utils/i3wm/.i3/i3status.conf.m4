general {
       output_format = "i3bar"
       colors = true
       interval = 1
       color_good = "#2aa198"
       color_degraded = "#b58900"
       color_bad  = "#dc322f"
       color_separator = "#46585e"
}

order  = "read_file weather"
order += "cpu_usage"
m4_ifdef(`zalman',
`order += "ethernet enp5s0"',
m4_ifdef(`thinkpad',
`order += "cpu_temperature 0"
order += "battery 0"
order += "ethernet eth0"
order += "wireless wlan0"'))
order += "volume master"
order += "tztime local"

read_file weather {
    path = "/home/drag0n/.cache/weather"
}

cpu_usage {
    format = "CPU %usage"
    max_threshold = 75
    degraded_threshold = 25
    format_above_threshold = "WARNING %usage"
    format_above_degraded_threshold = "DEGRADED %usage"
}

m4_ifdef(`zalman',
`ethernet enp5s0 {
    format_up = "🖧 %ip"
    format_down = "🖧 down"
}',
m4_ifdef(`thinkpad',
`cpu_temperature 0 {
    format = "🌡 %degrees °C"
}

battery 0 {
    format = "%status %percentage %remaining"
    format_down = "No battery"
    status_chr = "🔌"
    status_bat = "🔋"
    status_unk = "🕱"
    status_full = "🔋"
    threshold_type = "time"
    low_threshold = 10
    integer_battery_capacity = true
    last_full_capacity = true
}

ethernet eth0 {
    format_up = "🖧 %ip"
    format_down = "🖧 down"
}

wireless wlan0 {
    format_up = "📡 %essid"
    format_down = "📡 down"
    format_quality = "%03d%s"
}'))

volume master {
    format = "🔊"
    format_muted = "🔇"
    device = "hw:0"
    mixer = "Master"
}

tztime local {
    format = "%d-%m-%Y %H:%M:%S %a"
}

