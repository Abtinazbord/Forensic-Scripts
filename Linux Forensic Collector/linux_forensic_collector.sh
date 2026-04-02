#!/bin/bash
# Linux Live Response Collection Script
# Collects volatile and non-volatile system data for forensic purposes.
# Run as root for full data collection.
# Developed and tested on Kali Linux.

set -euo pipefail  # Exit on error, unset variables, and pipeline failures

echo "This program collects all the important forensic data from a Linux device."

workdir=$(pwd)
tools=$workdir/tools
output=$workdir/data

echo "Working directory : $workdir"
echo "Tools directory   : $tools"
echo "Output directory  : $output"

# Check for root and warn if not
if [ "$EUID" -ne 0 ]; then
    echo "WARNING: Script is not running as root. Some data (e.g. shadow file) will not be accessible."
fi

# Verify tools directory exists
if [ ! -d "$tools" ]; then
    echo "ERROR: Tools directory '$tools' not found. Exiting."
    exit 1
fi

# Create output directory
"$tools/mkdir" -p "$output"

# Session info
echo "Writing session info to session.log..."
{
    echo "Writing the session info to session.log"
    echo "Date:"
    "$tools/date"
    echo "Hostname:"
    "$tools/hostname"
    echo "whoami:"
    "$tools/whoami"
    echo "Uptime:"
    "$tools/uptime"
} > "$output/session.log"
echo "Done!"


# Process list
echo "Storing processes of the device..."
"$tools/ps" auxww            > "$output/ps_aux.txt"
"$tools/top" -b -n 1         > "$output/top.txt"
"$tools/pstree" -ap          > "$output/pstree.txt"
echo "Done!"


# Network connections
echo "Storing network connection data..."
"$tools/netstat" -anp        > "$output/netstat.txt"
"$tools/ss" -anp             > "$output/ss.txt"
"$tools/lsof" -i             > "$output/lsof_network.txt"
echo "Done!"


# Logged-in users
echo "Storing data of logged-in users..."
"$tools/who" -a              > "$output/who.txt"
"$tools/w"                   > "$output/w.txt"
"$tools/last" -a             > "$output/last.txt"    || true
echo "Done!"


# Open files and network tables
echo "Recording open files and network tables..."
"$tools/lsof"                > "$output/lsof.txt"
"$tools/arp" -a              > "$output/arp.txt"
"$tools/route" -n            > "$output/route.txt"
echo "Done!"


# NON-VOLATILE DATA
# System info
echo "Recording system info..."
"$tools/uname" -a            > "$output/uname.txt"
"$tools/df" -h               > "$output/disk_usage.txt"
"$tools/mount"               > "$output/mounts.txt"  || true
echo "Done!"


# User account info
echo "Recording user account info..."
"$tools/cat" /etc/passwd     > "$output/passwd.txt"

if [ "$EUID" -eq 0 ]; then
    "$tools/cat" /etc/shadow > "$output/shadow.txt"
else
    echo "WARNING: Skipping shadow file — re-run as root to capture it."
fi
echo "Done!"


# Scheduled tasks
echo "Recording scheduled tasks..."
"$tools/crontab" -l          > "$output/crontab_user.txt" 2>/dev/null || echo "(no user crontab)" > "$output/crontab_user.txt"
"$tools/cat" /etc/crontab    > "$output/crontab_system.txt"
echo "Done!"


# System logs
echo "Recording system logs..."
"$tools/cp" -r /var/log "$output/log"
echo "Done!"


# HASHING


echo "Hashing all collected data (recursive)..."
"$tools/find" "$output" -type f ! -name "hashes.txt" -exec "$tools/sha256sum" {} + > "$output/hashes.txt"
echo "Done!"

echo ""
echo "All data collected successfully in: $output"
