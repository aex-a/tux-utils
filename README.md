# tux-utils

## Table of Contents
+ [About](#about)
+ [Getting Started](#getting_started)
+ [Usage](#usage)
+ [Contributing](../CONTRIBUTING.md)

## About <a name = "about"></a>
This repository primarily exists to provide a home for shell scripts and services I'm working on or currently use in my day to day.

## Getting Started <a name = "getting_started"></a>
While you can clone this repo, it is currently (as of 02-17-2026) comprised of just a few shell scripts and a systemd service so its likely preferable to copy scripts to a location of your choosing.

### Prerequisites

##### For on demand scripts:

- Verify you have the commands being run installed on your system (seeing "command not found" is a good indication you're missing a command in use).

##### For service scripts:
The same prerequisites apply but I would advise reading the comments as they should provide additional insight into what the script is expecting when run.

### Installing

- Copy the script you would like to use to a file and save it.
- Ensure the script is executable before running

```
chmod +x script.sh
```
- Example of grab-color.sh output (truncated):
```
$ grab-color.sh
#121127
#525674
#203B88
#26579F
...
```


## Usage <a name = "usage"></a>

#### *services/q-length.sh*
Used to monitor q-length of a connection. 
- Includes a systemd unit file so it can be run as a service (use --user).
- Logs to ~/.logs/q.log
- If running as a service, ensure you've created and defined necessary variables in ~/.config/q-length.conf 

#### *on-demand/gaming-task.sh*
Used to automate tasks in gaming that require manual input at set intervals in a wayland env. 
- Could be used for other tasks but would require updating the variables accordingly.
- I may update this in the future as it currently uses hardcoded values 
*Don't use this is it would be considered against ToS for the game you're playing*

#### *on-demand/grab-colors.sh*
Used to grab a list of colors from ~/.cache/wal/colors.sh and format it so that it only lists the colors for use elsewhere.
