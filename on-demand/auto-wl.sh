#!/bin/bash
## Used to automate tasks in that require manual input at set intervals in a wayland env
## The keys used here did not directly correspond to the keys on my physical keyboard.
## For example, I believe using 6 here actually registered as 5 and 7 as 6 so be sure to check.

# [Changelog]
# 02-17-26: Updating for more general usecase (vs solely focusing on gaming), added vars for
# appid and sleep timer, added check to ensure wlrctl is installed.

WND=firefox
# Replace firefox with the app_id you're trying to automate on.
# In sway, you can determine the app id by running 'sway -t get_tree' where you should see it
# listed and prefixed with app_id:
# This script assumes you have one window open with the specified app_id name.
WAIT=15 # How long to sleep.

# Verify wlrctl is installed
if [[ -z "$(which wlrctl 2> /dev/null)" ]]; then
	echo "ERROR: wlrctl is not installed."
	exit 1
fi

# Example: wlrctl window focus steam_app_0 &&
wlrctl window focus $WND &&
wlrctl toplevel waitfor $WND state:focused &&
# Be advised, this will grab the cursor.
wlrctl pointer click &&
wlrctl keyboard type '6'
sleep $WAIT
wlrctl window focus $WND &&
wlrctl toplevel waitfor $WND state:focused &&
sleep 1 &&
wlrctl keyboard type '7'
