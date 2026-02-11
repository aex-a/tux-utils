#!/bin/bash
## Net Sock Monitor for queue length
# Accepts IP address to be monitored and alerting threshold as input.
# Example: q-length.sh $IP-ADDRESS $THRESHOLD

# [Changelog] 
# 02-10-26: Added read prompt,set -e, double quoted variables per shellcheck, testing required
# before merging to main.

if [[ -z "$1" ]]; then
read -p "Input the IP address you want to monitor queue length for:" $1
elif [[ -z "$2" ]]; then
read -p "Input the threshold for logging high queue length:" $2
else
echo "IP address is set to $1 and threshold is set to $2"
fi

# Check if log directory exists

if [[ -d $(ls "${HOME}"/.logs 2>/dev/null) ]]; then
echo "Logging to $LOGFILE"
else mkdir -p "${HOME}"/.logs & echo "Logging to $LOGFILE"
fi

LOGFILE="${HOME}"/.logs/q.log
THR="$1"
INTV=0.5
IP="$2"

while true; do
ss -t -H dst $IP | awk -v threshold="$THR" \
'$3 > threshold { \
print "[ " strftime("%Y-%m-%d %H:%M:%S") " ] - INFO: High Send-Q found."; \
# Prefaced with INFO to set log level when monitoring
print $0 \
}' >> "$LOGFILE"
sleep "$INTV"
done

# NOTE: this iteration requires specifying ip and threshold whereas previous iterations
# required manually editing before running. If these values are not expected to change
# feel free to comment out the version requiring input and uncomment the previous version
# shown below

##########################################################################################

#LOGFILE=~/.logs/q.log
#THR=80
#INTV=0.5
# I've commented out this variable but it should be uncommented and replaced
#IP=0.0.0.0

#while true; do
#ss -t -H dst $IP | awk -v threshold="$THR" \
#'$3 > threshold { \
#print "[ " strftime("%Y-%m-%d %H:%M:%S") " ] - INFO: High Send-Q found."; \
# Prefaced with INFO to set log level when monitoring
#print $0 \
#}' >> "$LOGFILE"
#sleep "$INTV"
#done
