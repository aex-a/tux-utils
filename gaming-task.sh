#!/bin/bash
## Used to automate tasks in gaming that require manual input at set intervals in a wayland env
## Don't use this is it would be considered against ToS for the game you're playing
## The keys used here did not directly correspond to the keys on my physical keyboard.
## For example, I believe using 6 here actually registered as 5 and 7 as 6 so be sure to check.

wlrctl window focus steam_app_0 &&
wlrctl toplevel waitfor steam_app_0 state:focused &&
# because of how wayland works if the window isn't focused this doesn't work
# this does mean that if you're doing something in another window it will grab focus to complete
# the next step
wlrctl pointer click &&
wlrctl keyboard type '6'
sleep 38
wlrctl window focus steam_app_0 &&
wlrctl toplevel waitfor steam_app_0 state:focused &&
sleep 1 &&
wlrctl keyboard type '7'
