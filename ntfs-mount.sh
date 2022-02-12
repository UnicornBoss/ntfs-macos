#!/bin/bash

set -e

# Find volume info
if [[ $# -eq 0 ]]
then
  echo "Please provide a volume name as an argument."
  exit 1
fi

echo "Collecting information on '$1'..."

info=$(diskutil info "$1")
find_value () {
  echo "$info" | grep "$1:" | awk '{ print $NF }'
}

id=$(find_value "Device Identifier")
mounted=$(find_value "Mounted")
type=$(find_value "File System Personality")

if [[ "$type" != "NTFS" ]]
then
  echo "Cannot mount volume because it's not of type NTFS."
  exit 1
fi

echo -e "Found id '$id' for volume '$1', mounting..."

# Unmount if necessary
if [[ "$mounted" == "Yes" ]]
then
  sudo diskutil unmount /dev/$id > /dev/null
fi

# Mount volume
sudo mkdir -p /Volumes/NTFS
sudo /usr/local/bin/ntfs-3g /dev/$id /Volumes/NTFS -o local,allow_other,auto_xattr,auto_cache 

echo "Volume successfully mounted."
