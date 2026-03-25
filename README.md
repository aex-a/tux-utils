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
- **Architecture:** Dual-mode execution. Automatically detects environment to run interactively via TTY (with user prompts) or seamlessly as a background system-level daemon (`multi-user.target`).
- **Config:** Decouples logic from configuration using `/etc/q-length.conf` for system services, or environment variables for local execution.
- **Logging:** Context-aware logging. Writes to `~/.logs/q.log` when run interactively, or outputs directly to `stdout` for native `journalctl` integration when run as a system daemon. 

### *on-demand/auto-wl.sh*
An automation script for timed input simulation in Wayland environments.
- **Tech Stack:** Demonstrates scripting for modern display protocols (Wayland) where X11 tools (xdotool) fail.
- **Use Case:** Automates sequential tasks on demand.

### *on-demand/grab-colors.sh*
A parsing tool to sanitize and format color schemes from pywal caches.
- **Function:** Parses ~/.cache/wal/colors.sh using sed/awk to generate clean hex-code lists for downstream applications.
