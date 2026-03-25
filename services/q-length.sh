#!/bin/bash
## Net Sock Monitor for queue length
# Accepts IP address to be monitored and alerting threshold as input.

# Detect if running in an interactive terminal (TTY)
if [ -t 1 ]; then
	INTERACTIVE=1
	LOGDIR="${HOME}/.logs"
	LOGFILE="${LOGDIR}/q.log"

	# Make the log directory if interactive
	mkdir -p "$LOGDIR" || {
		echo "ERROR: Couldn't create logs directory at $LOGDIR"
		exit 1
	}
	echo "Logging to $LOGFILE"
else
	INTERACTIVE=0
	# For systemd, we log to stdout so journalctl catches it.
	LOGFILE="/dev/stdout"
fi

INTV=0.5
IP="${1:-${IP:-}}" # Check args first, then environment variables (from systemd)
THR="${2:-${THR:-}}"

# Interactive Prompts (Only run if attached to a terminal)
if [ "$INTERACTIVE" -eq 1 ]; then
	if [[ -z "$IP" ]]; then
		read -rp "Input the IP address you want to monitor queue length for: " IP
	else
		echo "IP address is set to $IP"
	fi

	if [[ -z "$THR" ]]; then
		read -rp "Input the threshold for logging high queue length: " THR
	else
		echo "Threshold is set to $THR"
	fi
fi

# Final Validation (If variables are still missing, fail safely)
if [[ -z "$IP" ]] || [[ -z "$THR" ]]; then
	echo "ERROR: Missing IP or Threshold. If running as a service, ensure EnvironmentFile is configured." >&2
	exit 1
fi

# Graceful Shutdown function
cleanup() {
    echo "[ $(date '+%Y-%m-%d %H:%M:%S') ] - INFO: Received termination signal. Shutting down gracefully." >> "$LOGFILE"
    exit 0
}

# Trap SIGINT (Ctrl+C) and SIGTERM (systemctl stop)
trap cleanup SIGINT SIGTERM
   
   # Begin monitoring and logging
   while true; do
       if [ "$INTERACTIVE" -eq 1 ]; then
           ss -t -H dst "$IP" | awk -v threshold="$THR" \
               '$3 > threshold { print "[ " strftime("%Y-%m-%d %H:%M:%S") " ] - INFO: High Send-Q found."; print $0 }' >> "$LOGFILE"
       else
           ss -t -H dst "$IP" | awk -v threshold="$THR" \
               '$3 > threshold { print "[ " strftime("%Y-%m-%d %H:%M:%S") " ] - INFO: High Send-Q found."; print $0 }'
       fi
       sleep "$INTV"
   done

