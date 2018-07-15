#!/bin/bash
# Based on http://openweathermap.org/current

API_KEY="886705b4c1182eb1c69f28eb8c520e20"

# Check on http://openweathermap.org/find
CITY_ID="498817"

SYMBOL_CELSIUS="℃"

WEATHER_URL="http://api.openweathermap.org/data/2.5/weather?id=${CITY_ID}&appid=${API_KEY}&units=metric"

WEATHER_INFO=`wget -qO- "${WEATHER_URL}" || echo "err"`
if [ "$WEATHER_INFO" != "err" ]; then
	WEATHER_TEMP=$(echo "${WEATHER_INFO}" | grep -o -e '\"temp\":\-\?[0-9]*' | awk -F ':' '{print $2}' | tr -d '"')
	FIRST_CHAR=$(echo "${WEATHER_TEMP}" | cut -c 1)
	if [[ "${FIRST_CHAR}" != "-" ]]; then
		WEATHER_TEMP="+${WEATHER_TEMP}"
	fi
	echo "${WEATHER_TEMP}${SYMBOL_CELSIUS}"
	echo "${WEATHER_TEMP}${SYMBOL_CELSIUS}"
else
	echo "err${SYMBOL_CELSIUS}"
	echo "err${SYMBOL_CELSIUS}"
	echo "#FF5722"
fi
