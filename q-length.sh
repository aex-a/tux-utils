#!/bin/bash
## Net Sock Monitor for queue length                                           
# Accepts IP address to be monitored and alerting threshold as input.          
# Example: q-length.sh $IP $THR
# Note: If either variables are not included, q-length witll request them.

# [Changelog]
# 02-10-26: Added read prompt,set -e, double quoted variables per shellcheck, 
# testing required before merging to main.

# 02-12-26: Swapped elif for two separate if else, modified variables for
# IP & THR so they're easier to check during if else pair, updated script
# name to reflect what is shown in example, added check with boolean OR
# to ensure both variables are set before proceeding, added check to verify
# directory exists before proceeding, updated log variables and modified check 
# since mkdir will fail if the dir already exists, decreased col count for
# visibility since I'm typically splitting windows in a tiling wm

LOGDIR="${HOME}/.logs"
LOGFILE="${LOGDIR}/q.log"

INTV=0.5
IP="${1:-}"
THR="${2:-}"

# Check if IP was provided, if not request it,otherwise print what its set to

if [[ -z "$IP" ]]; then
	read -rp "Input the IP address you want to monitor queue length for:" IP
else
	echo "IP address is set to $IP"
fi

# Check if THR was provided, if not request it,otherwise print what its set to

if [[ -z "$THR" ]]; then
	read -rp "Input the threshold for logging high queue length:" THR
else
	echo "Threshold is set to $THR"
fi

# Check if either IP or THR are missing after prompting.

if [[ -z "$IP" ]] || [[ -z "$THR" ]]; then
	echo "ERROR: Please include IP & threshold when running q-length.sh 
	or supply them when prompted."
	exit 1
fi

# Make the log directory and output errors to dev null in case it already
# exists.

mkdir -p "$LOGDIR"
if [ $? -ne 0 ]; then
  echo "ERROR: Couldn't create logs directory at $LOGDIR"
  exit 1
fi

# Let the user know where they're logging.

echo "Logging to $LOGFILE"

# Begin monitoring and logging
while true; do
	ss -t -H dst "$IP" | awk -v threshold="$THR" \
		'$3 > threshold { \
print "[ " strftime("%Y-%m-%d %H:%M:%S") " ] - INFO: High Send-Q found."; \
# Prefaced with INFO to set log level when monitoring
print $0 \
}' >>"$LOGFILE"

	sleep "$INTV"
done
