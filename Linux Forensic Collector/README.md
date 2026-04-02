LIVE RESPONSE THUMB DRIVE
Ubuntu Linux 64-bit

REQUIREMENTS
------------
- Must be run on Ubuntu Linux 64-bit
- Must be run as root for full data collection

NOTE: This script was developed and tested on Kali Linux. If any
commands produce errors on your system, open the response script
in a text editor and comment out the affected lines by placing a
# at the beginning of the line, then re-run the script.


HOW TO RUN
----------
1. Plug in the thumb drive.

2. Navigate to the root of the thumb drive:

        cd /media/<username>/LDD

4. Execute the script using bash directly:

        sudo bash response

5. Collected data will be saved to the /data folder on the thumb drive.


FOLDER STRUCTURE
----------------
/response                     -> main bash script
/readme                       -> this file
/tools/                       -> trusted tool binaries
/data/                        -> output folder (created automatically)
