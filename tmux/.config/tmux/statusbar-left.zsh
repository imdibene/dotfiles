#!/usr/bin/env zsh

function memory_usage::macos() {
	# Get the PhysMem line
	physmem=$(top -l 1 -s 0 | grep "PhysMem")

	# Extract used and unused memory values (in Gigabytes)
	used_mem=$(echo "$physmem" | sed -n 's/.*PhysMem: \([0-9]*G\) used.*/\1/p')
	unused_mem=$(echo "$physmem" | sed -n 's/.* \([0-9]*G\) unused.*/\1/p')

	# Convert the values from G to MB
	used_mem_mb=$(( ${used_mem%G} * 1024 ))   # Remove the "G" and multiply by 1024 to get MB
	unused_mem_mb=$(( ${unused_mem%G} * 1024 ))

	# Calculate the total memory in MB
	total_mem_mb=$(( used_mem_mb + unused_mem_mb ))

	# Calculate the percentage of used memory
	usage_percent=$(( used_mem_mb * 100 / total_mem_mb ))

	# Print the results
	echo "MEM:$usage_percent%"
}

function memory_usage::linux() {
	# Get memory information in megabytes
	mem_info=$(free -m | grep Mem)

	# Extract total and used memory from the output
	total_mem=$(echo "$mem_info" | awk '{print $2}')
	used_mem=$(echo "$mem_info" | awk '{print $3}')

	# Calculate percentage of used memory
	used_percentage=$(( (used_mem * 100) / total_mem ))

	# Display the result
	echo "MEM:$used_percentage%"
}

function memory_usage() {
	case "$(uname -s)" in
	Darwin)
		memory_usage::macos
		;;
	Linux)
		memory_usage::linux
		;;
	*)
		echo "Unsupported OS"
		;;
	esac
}

function ipaddr() {
	case "$(uname -s)" in
	Darwin)
		ipaddr::macos
		;;
	Linux)
		ipaddr::linux
		;;
	*)
		echo "Unsupported OS"
		;;
	esac
}

function ipaddr::linux() {
	for iface in /sys/class/net/*; do
		iface_name=$(basename "$iface")
		read -r status < "$iface/operstate"
		if [ "$status" = "up" ]; then
			ip addr show "$iface_name" | awk '/inet /{print $2}'
		fi
	done
}

function ipaddr::macos() {
	for iface in $(ifconfig -l); do
		if_status=$(ifconfig "$iface" | grep 'status' | awk '{print $2}')
		if [ "$if_status" = "active" ]; then
			ip=$(ifconfig "$iface" | awk '/inet /{print $2}')
			if ! [ -z "$ip" ] && printf "%s->%s " "$iface" "$ip"
		fi
	done
}

function vpn_conn::macos() {
	# Find all utun interfaces
	for iface in $(ifconfig | grep '^utun[0-9]' | awk '{print $1}' | sed 's/://'); do
	# Check the status of each utun interface
		if ifconfig "$iface" | grep -q 'status: active'; then
			printf "%s " "$iface->VPN*"
		fi
	done
}

function vpn_conn::linux() {
	if [ -d /sys/class/net/tun0 ]; then
		printf "%s " "VPN* (tun0 active)"
	elif [ -d /sys/class/net/wg0 ]; then
		printf "%s " "VPN* (WireGuard active)"
	fi
}

function vpn_conn() {
	case "$(uname -s)" in
	Darwin)
		vpn_conn::macos
		;;
	Linux)
		vpn_conn::linux
		;;
	*)
		echo "Unsupported OS"
		;;
	esac
}

function main() {
	ipaddr
	memory_usage
	vpn_conn
}

main
