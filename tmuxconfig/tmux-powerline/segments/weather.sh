#!/bin/bash
# Prints the current weather in Celsius, Fahrenheits or lord Kelvins. The forecast is cached and updated with a period of $update_period.

# Your location. You can specify the longitude and latitude, otherwise the location name will be resolved via openstreetmap.
# The first result from openstreetmap will be used, feel free to enter your address for optimal mapping.
# If in doubt, check that your location is the first match on http://openstreetmap.org
location="Calgary, Alberta"
#latitude=55.7029296
#longitude=13.1929449

# In seconds
update_period=1600

# Can be any of {c,f,k}.
unit="c"

tmp_file="/tmp/tmux-powerline_weather.txt"

get_condition_symbol() {
	local conditions=$(echo "$1" | tr '[:upper:]' '[:lower:]')
	case "$conditions" in
	sunny | "partly sunny" | "mostly sunny")
		hour=$(date +%H)
		if [ "$hour" -ge "22" -o "$hour" -le "5" ]; then
			#echo "☽"
			echo "☾"
		else
			#echo "☀"
			echo "☼"
		fi
		;;
	"rain and snow" | "chance of rain" | "light rain" | rain | "heavy rain" | "freezing drizzle" | flurries | showers | "scattered showers" | drizzle | "rain showers")
		#echo "☂"
		echo "☔"
		;;
	snow | "light snow" | "scattered snow showers" | icy | ice/snow | "chance of snow" | "snow showers" | sleet)
		#echo "☃"
		echo "❅"
		;;
	"partly cloudy" | "mostly cloudy" | cloudy | overcast)
		echo "☁"
		;;
	"chance of storm" | thunderstorm | "chance of tstorm" | storm | "scattered thunderstorms")
		#echo "⚡"
		echo "☈"
		;;
	dust | fog | smoke | haze | mist)
		echo "♨"
		;;
	windy)
		echo "⚑"
		#echo "⚐"
		;;
	clear)
		#echo "☐"
		echo "✈"	# So clear you can see the aeroplanes! TODO what symbol does best represent a clear sky?
		;;
	*)
		echo "？"
		;;
	esac
}

read_tmp_file() {
	if [ ! -f "$tmp_file" ]; then
		return
	fi
	IFS_bak="$IFS"
	IFS=$'\n'
	lines=($(cat ${tmp_file}))
	IFS="$IFS_bak"
	degrees="${lines[0]}"
	conditions="${lines[1]}"
}

degrees=""
if [ -f "$tmp_file" ]; then
	if [ "$PLATFORM" == "mac" ]; then
		last_update=$(stat -f "%m" ${tmp_file})
	else
		last_update=$(stat -c "%Y" ${tmp_file})
	fi
	time_now=$(date +%s)
	update_period=${update_period:-600}

	up_to_date=$(echo "(${time_now}-${last_update}) < ${update_period}" | bc)
	if [ "$up_to_date" -eq 1 ]; then
		read_tmp_file
	fi
fi

if [ -z "$degrees" ]; then
	# Convert spaces before using this in the URL.
	if [ -z "$latitude" -o -z "$longitude" ]; then
		if [ "$PLATFORM" == "mac" ]; then
			search_location=$(echo "$location" | sed -e 's/[ ]/%20/g')
		else
			search_location=$(echo "$location" | sed -e 's/\s/%20/g')
		fi
		location_data="$(curl --max-time 4 -s "http://nominatim.openstreetmap.org/search?q=Calgary,%20Alberta&format=json")"
		latitude="$(echo $location_data|sed -e 's#^.*"lat":"\([^"]*\)".*$#\1#g')"
		longitude="$(echo $location_data|sed -e 's#^.*"lon":"\([^"]*\)".*$#\1#g')"
	fi

	if [ -z "$latitude" -o -z "$longitude" ]; then
		echo "error"
		exit 1
	fi
	weather_data="$(curl --max-time 4 -s "http://openweathermap.org/data/2.0/find/station?lat=${latitude}&lon=${longitude}&cnt=15&cluster=true")"
	if [ "$?" -eq "0" ]; then
		degrees="$(echo $weather_data|sed -e 's#^.*"main":{"temp":\([^,]*\),.*$#\1#g')"
		conditions=''
		echo "$degrees" > $tmp_file
		echo "$conditions" >> $tmp_file
	elif [ -f "$tmp_file" ]; then
		read_tmp_file
	fi
fi

if [ -n "$degrees" ]; then
	if [ "$unit" == "c" ]; then
		degrees=$(echo "${degrees} - 273.15" | bc)
	elif [ "$unit" == "f" ]; then
		degrees=$(echo "(${degrees} * 9 / 5) - 459.67" | bc)
	fi
	unit_upper=$(echo "$unit" | tr '[cfk]' '[CFK]')
	condition_symbol=$(get_condition_symbol "$conditions")
	echo "${condition_symbol} ${degrees}°${unit_upper}"
fi
