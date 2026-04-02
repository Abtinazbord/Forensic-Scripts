LIVE RESPONSE THUMB DRIVE


REQUIREMENTS
------------
- Must be run as root for full data collection
- All the files must be in a removable dirve with ext3 or ext4 filesystem in order to maintain the integrity of the device.

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
