#!/usr/bin/env zsh

function battery_meter::macos() {
	# Get battery status from pmset
	power_info=$(pmset -g batt)
	src=$(echo $power_info | grep "Now drawing from" | sed -n "s/.*'\\(.*\\)'.*/\\1/p")
	percent=$(echo $power_info | grep -Eo '\d{1,3}%')
	state=$(echo $power_info | grep -E '\d{1,3}%' | awk -F';' '{print $2}')

	# Get battery status from the system profiler
	batt_info=$(system_profiler SPPowerDataType | sed -n '/Charge Information:/,/System Power Settings:/p' | sed '$d')
	charging=$(echo "$batt_info" | grep "Charging:" | awk '{print $2}')

	# choose a symbol based on the battery status
	if [[ $charging == "Yes" ]]; then
		symbol="🔋⚡️"	# battery is charging
	elif [[ $charging == "No" ]] && [[ $src == "AC Power" ]]; then
		symbol="🔋🔌"	# battery either fully charged or smart charging mode active
	elif [[ $src == "Battery Power" ]]; then
		symbol="🔋"
	else
		symbol="❓"	# unknow state
	fi
	# display battery state
	printf "%s " "$symbol $percent"
}

function battery_meter::linux() {
	# Check if the battery info is available
	if [[ -f /sys/class/power_supply/BAT0/capacity ]]; then
		# Get battery percentage and status (charging/discharging/fully charged)
		battery_percentage=$(cat /sys/class/power_supply/BAT0/capacity)
		battery_status=$(cat /sys/class/power_supply/BAT0/status)

		# Choose a symbol based on the battery status
		if [[ $battery_status == "Discharging" ]]; then
			symbol="🔋"   # Battery is discharging
		elif [[ $battery_status == "Charging" ]]; then
			symbol="⚡️"  # Battery is charging
		elif [[ $battery_status == "Full" ]]; then
			symbol="🔌"  # Battery is fully charged
		else
			symbol="❓"   # Unknown state
		fi

		# Display battery status with symbol
		printf"%s " "$symbol $battery_percentage%"
	else
		echo "Battery information not available."
	fi
}

function battery_meter() {
	case "$(uname -s)" in
	Darwin)
		battery_meter::macos
		;;
	Linux)
		battery_meter::linux
		;;
	*)
		# Other OSes
		;;
	esac
}

function load_avg() {
	printf "%s " "$(uptime | awk -F: '{print $NF}')"
}

function date_time() {
	printf "%s " "$(date +'%a %Y-%h-%d J:%j W:%U %H:%M')" }

function main() {
	battery_meter
	load_avg
	date_time
}

main
