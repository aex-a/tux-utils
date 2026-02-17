# tux-utils

## Table of Contents
+ [About](#about)
+ [Overview](#overview)
+ [Utilities](#utilities)

## About <a name = "about"></a>
A collection of system administration utilities, background services, and automation scripts for use in Linux systems. 

## Overview <a name = "overview"></a>
This repository demonstrates practical automation for:

- **System Reliability:** Network socket monitoring with automated logging and recovery.

- **Desktop Automation:** Wayland-native input simulation and color scheme extraction.

- **Service Management:** Systemd unit integration for background tasks.

### Prerequisites

- **OS:** Linux, wayland desktop (auto-wl.sh)
- **Dependencies:** systemd (q-length.sh service), bash, coreutils, wlrctl (auto-wl.sh)

### Installing

- Clone the repository or copy individual scripts
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


## Utilities <a name = "utilities"></a>

### *services/q-length.sh*
Bash daemon designed to monitor network queue lengths that can optionally be run as a service.
- **Architecture:** Run as needed or as a user-level systemd service with automatic restart policies (Restart=on-failure).
- **Reliability:** Implements signal trapping (SIGINT/SIGTERM) for graceful shutdowns.
- **Config:** Decouples logic from configuration using ~/.config/q-length.conf and environment variables.
- **Logging:** Rotates logs to ~/.logs/q.log to prevent disk exhaustion.

### *on-demand/auto-wl.sh*
An automation script for timed input simulation in Wayland environments.
- **Tech Stack:** Demonstrates scripting for modern display protocols (Wayland) where X11 tools (xdotool) fail.
- **Use Case:** Automates sequential tasks on demand.

### *on-demand/grab-colors.sh*
A parsing tool to sanitize and format color schemes from pywal caches.
- **Function:** Parses ~/.cache/wal/colors.sh using sed/awk to generate clean hex-code lists for downstream applications.
