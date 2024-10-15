#!/bin/bash

# Foo Script
# Description: This is a boilerplate for a Bash script that can be modified for various purposes.
# Author: Your Name
# Date: $(date +%Y-%m-%d)

# Exit immediately if a command exits with a non-zero status
set -e

# Define Colors for output (optional)
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Usage function to display help for the script
usage() {
	echo -e "${GREEN}Usage:${NC} $0 [-h] [-v] [-f <arg>]"
	echo -e "\nOptions:"
	echo -e "  -h		   Show this help message"
	echo -e "  -v		   Enable verbose mode"
	echo -e "  -f <arg>	 Example argument with a required parameter"
	exit 1
}

# Logging functions
log_info() {
	echo -e "${GREEN}[INFO]${NC} $1"
}

log_error() {
	echo -e "${RED}[ERROR]${NC} $1"
}

# Example function
do_something() {
	local arg="$1"
	log_info "Doing something with argument: $arg"
	# Your code here
}

# Parse command-line arguments
VERBOSE=0
while getopts "hvf:" opt; do
	case ${opt} in
		h )
			usage
			;;
		v )
			VERBOSE=1
			;;
		f )
			ARGUMENT="$OPTARG"
			;;
		\? )
			log_error "Invalid option: -$OPTARG"
			usage
			;;
		: )
			log_error "Option -$OPTARG requires an argument."
			usage
			;;
	esac
done
shift $((OPTIND -1))

# Enable verbose mode if requested
if [ "$VERBOSE" -eq 1 ]; then
	set -x
	log_info "Verbose mode enabled"
fi

# Check if a required argument was provided
if [ -z "$ARGUMENT" ]; then
	log_error "The -f argument is required."
	usage
fi

# Main script logic
log_info "Starting script..."

do_something "$ARGUMENT"

log_info "Script finished successfully."

