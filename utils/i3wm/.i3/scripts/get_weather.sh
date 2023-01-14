#!/usr/bin/env sh

WEATHER=/home/drag0n/.cache/weather

curl -s 'https://api.openweathermap.org/data/2.5/weather?lat='$(/home/drag0n/.bin/geocoords.sh lat)'&lon='$(/home/drag0n/.bin/geocoords.sh lon)'&appid='$(cat /home/drag0n/.openweathermap)'&units=metric' | \
    jq -Mj '"🌀 " + (.main.temp | tostring) + "°C ", (.main.feels_like | tostring) + "°C ", .weather[0].icon, " (" + (.weather[0].description | tostring | ascii_downcase) + ")"' | \
    sed -r \
        -e 's/(.+°C )01[dn]( \(.*\))/\1☀️\2/g'  \
        -e 's/(.+°C )02[dn]( \(.*\))/\1🌤\2/g' \
        -e 's/(.+°C )03[dn]( \(.*\))/\1🌥\2/g' \
        -e 's/(.+°C )04[dn]( \(.*\))/\1☁\2/g'  \
        -e 's/(.+°C )09[dn]( \(.*\))/\1🌧\2/g' \
        -e 's/(.+°C )10[dn]( \(.*\))/\1🌦\2/g' \
        -e 's/(.+°C )11[dn]( \(.*\))/\1🌩\2/g' \
        -e 's/(.+°C )13[dn]( \(.*\))/\1❄\2/g'  \
        -e 's/(.+°C )50[dn]( \(.*\))/\1🌫\2/g' \
    > "$WEATHER"

if [ "$?" -ne "0" ]; then
    echo "No weather data :-(" > "$WEATHER"
fi

