#!/bin/sh

# Foo Script
# Description: POSIX-compliant shell script template
# Author: Your Name
# Date: $(date +%Y-%m-%d)

# Exit immediately if a command exits with a non-zero status
set -e

# Colors for output (POSIX-compliant)
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Usage function to display help for the script
usage() {
	echo "${GREEN}Usage:${NC} $0 [-h] [-v] [-f <arg>]"
	echo ""
	echo "Options:"
	echo "  -h		   Show this help message"
	echo "  -v		   Enable verbose mode"
	echo "  -f <arg>	 Example argument with a required parameter"
	exit 1
}

# Logging functions
log_info() {
	printf "%s%s[INFO]%s %s\n" "$GREEN" "$1" "$NC" "$2"
}

log_error() {
	printf "%s%s[ERROR]%s %s\n" "$RED" "$1" "$NC" "$2"
}

# Example function
do_something() {
	arg="$1"
	log_info "" "Doing something with argument: $arg"
	# Your code here
}

# Parse command-line arguments
VERBOSE=0
ARGUMENT=""
while getopts "hvf:" opt; do
	case "$opt" in
		h)
			usage
			;;
		v)
			VERBOSE=1
			;;
		f)
			ARGUMENT="$OPTARG"
			;;
		\?)
			log_error "" "Invalid option: -$OPTARG"
			usage
			;;
		:)
			log_error "" "Option -$OPTARG requires an argument."
			usage
			;;
	esac
done
shift $((OPTIND - 1))

# Enable verbose mode if requested
if [ "$VERBOSE" -eq 1 ]; then
	set -x
	log_info "" "Verbose mode enabled"
fi

# Check if a required argument was provided
if [ -z "$ARGUMENT" ]; then
	log_error "" "The -f argument is required."
	usage
fi

# Main script logic
log_info "" "Starting script..."

do_something "$ARGUMENT"

log_info "" "Script finished successfully."

