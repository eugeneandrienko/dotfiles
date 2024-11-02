#!/usr/bin/env zsh

WEATHER_DATA=$(mktemp /tmp/weather.XXXXXX)
WEATHER_URL='https://api.open-meteo.com/v1/forecast?'
WEATHER_URL+='latitude='$($HOME/.bin/geocoords.sh lat)
WEATHER_URL+='&longitude='$($HOME/.bin/geocoords.sh lon)
WEATHER_URL+='&current=temperature_2m,relative_humidity_2m,apparent_temperature,'
WEATHER_URL+='is_day,precipitation,rain,showers,snowfall,weather_code,cloud_cover,'
WEATHER_URL+='surface_pressure,wind_speed_10m,wind_direction_10m,wind_gusts_10m'
WEATHER_URL+='&wind_speed_unit=ms&timezone=Europe%2FMoscow&models=metno_seamless'

curl -so "$WEATHER_DATA" "$WEATHER_URL"

TEMPERATURE=$(cat "$WEATHER_DATA" | \
                  jq -M '(.current.temperature_2m | tostring) + "°C"' | \
                  tr -d '["]')
UPDATE_DATE=$(cat "$WEATHER_DATA" | \
                  jq -M '(.current.time | strptime("%Y-%m-%dT%H:%M") | strftime("%Y-%m-%d %H:%M"))' | \
                  tr -d '["]')
HUMIDITY=$(cat "$WEATHER_DATA" | \
               jq -M '(.current.relative_humidity_2m | tostring) + "%"' | \
               tr -d '["]')
CLOUD_COVER=$(cat "$WEATHER_DATA" | \
                  jq -M '(.current.cloud_cover | tostring) + "%"' | \
                  tr -d '["]')
PRESSURE=$(cat "$WEATHER_DATA" | \
               jq -M '(.current.surface_pressure | . * 0.75 | tostring) + " mmHg"' | \
               tr -d '["]')
WIND_SPEED=$(cat "$WEATHER_DATA" | \
                 jq -M '(.current.wind_speed_10m | tostring) + " m/s"' | \
                 tr -d '["]')
WIND_GUSTS=$(cat "$WEATHER_DATA" | \
                 jq -M '(.current.wind_gusts_10m | tostring) + " m/s"' | \
                 tr -d '["]')

cat << EOF > $HOME/.cache/weather
Temperature:    $TEMPERATURE
Humidity:       $HUMIDITY
Cloud coverage: $CLOUD_COVER
Wind speed:     $WIND_SPEED
Wind gusts:     $WIND_GUSTS
Updated:        $UPDATE_DATE
EOF

WEATHER_CODE=$(cat "$WEATHER_DATA" | \
                   jq -M '(.current.weather_code | tostring)' | \
                   tr -d '["]')
IS_DAY=$(cat "$WEATHER_DATA" | jq -M  '.current.is_day')
WEATHER_IMG="$HOME/.config/conky/weather-codes/"
case "$WEATHER_CODE" in
    "0"|"1")
        WEATHER_IMG+="0-"
        ;;
    "2")
        WEATHER_IMG+="2-"
        ;;
    "3")
        WEATHER_IMG+="3-"
        ;;
    "51"|"53"|"55"|"56"|"57"|"80"|"81"|"82")
        WEATHER_IMG+="9-"
        ;;
    "61"|"63"|"65"|"67")
        WEATHER_IMG+="10-"
        ;;
    "95"|"96"|"99")
        WEATHER_IMG+="11-"
        ;;
    "71"|"73"|"75"|"77"|"85"|"86")
        WEATHER_IMG+="13-"
        ;;
    "45"|"48")
        WEATHER_IMG+="50-"
        ;;
    "*")
        WEATHER_IMG+="unknown-"
        ;;
esac
if [ "$IS_DAY" -ne 0 ]; then
    WEATHER_IMG+="day"
else
    WEATHER_IMG+="night"
fi
WEATHER_IMG+=".png"

case "$WEATHER_CODE" in
    "0")
        WEATHER_DESCRIPTION=$([ "$IS_DAY" -ne 0 ] && echo "Sunny" || echo "Clear")
        ;;
    "1")
        WEATHER_DESCRIPTION=$([ "$IS_DAY" -ne 0 ] && echo "Mainly Sunny" || "Mainly Clear")
        ;;
    "2")
        WEATHER_DESCRIPTION="Partly Cloudy"
        ;;
    "3")
        WEATHER_DESCRIPTION="Cloudy"
        ;;
    "45")
        WEATHER_DESCRIPTION="Foggy"
        ;;
    "48")
        WEATHER_DESCRIPTION="Rime Fog"
        ;;
    "51")
        WEATHER_DESCRIPTION="Light Drizzle"
        ;;
    "53")
        WEATHER_DESCRIPTION="Drizzle"
        ;;
    "55")
        WEATHER_DESCRIPTION="Heavy Drizzle"
        ;;
    "56")
        WEATHER_DESCRIPTION="Light Freezing Drizzle"
        ;;
    "57")
        WEATHER_DESCRIPTION="Freezing Drizzle"
        ;;
    "61")
        WEATHER_DESCRIPTION="Light Rain"
        ;;
    "63")
        WEATHER_DESCRIPTION="Rain"
        ;;
    "65")
        WEATHER_DESCRIPTION="Heavy Rain"
        ;;
    "66")
        WEATHER_DESCRIPTION="Light Freezing Rain"
        ;;
    "67")
        WEATHER_DESCRIPTION="Freezing Raing"
        ;;
    "71")
        WEATHER_DESCRIPTION="Light Snow"
        ;;
    "73")
        WEATHER_DESCRIPTION="Snow"
        ;;
    "75")
        WEATHER_DESCRIPTION="Heavy Snow"
        ;;
    "77")
        WEATHER_DESCRIPTION="Snow Grains"
        ;;
    "80")
        WEATHER_DESCRIPTION="Light Showers"
        ;;
    "81")
        WEATHER_DESCRIPTION="Showers"
        ;;
    "82")
        WEATHER_DESCRIPTION="Heavy Showers"
        ;;
    "85")
        WEATHER_DESCRIPTION="Light Snow Showers"
        ;;
    "86")
        WEATHER_DESCRIPTION="Snow Showers"
        ;;
    "95")
        WEATHER_DESCRIPTION="Thunderstorm"
        ;;
    "96")
        WEATHER_DESCRIPTION="Light Thunderstorms with Hail"
        ;;
    "99")
        WEATHER_DESCRIPTION="Thunderstorm with Hail"
        ;;
    "*")
        WEATHER_DESCRIPTION="Unknown weather code: $WEATHER_CODE"
        ;;
esac

APPARENT_TEMPERATURE=$(cat "$WEATHER_DATA" | \
                           jq -M '(.current.apparent_temperature | tostring) + "°C"' | \
                           tr -d '["]')
WEATHER_DESCRIPTION+=": $APPARENT_TEMPERATURE"

cp "$WEATHER_IMG" $HOME/.cache/weather.png
echo "$WEATHER_DESCRIPTION" > $HOME/.cache/weather.descr

rm -f "$WEATHER_DATA"
