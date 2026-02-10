#!/bin/bash
## script to monitor queue length of a connection using ss & awk

LOGFILE=~/.logs/q.log
THR=80
INTV=0.5
# I've commented out this variable but it should be uncommented and replaced
#IP=0.0.0.0

while true; do
ss -t -H dst $IP | awk -v threshold="$THR" \
'$3 > threshold { \
print "[ " strftime("%Y-%m-%d %H:%M:%S") " ] - INFO: High Send-Q found."; \
# Prefaced with INFO to set log level when monitoring
print $0 \
}' >> "$LOGFILE"
sleep "$INTV"
done
