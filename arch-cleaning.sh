#!/bin/bash

# Check if any systemd services have entered in a failed state
sudo systemctl --failed

# Look for high priority errors in the systemd journal
sudo journalctl -p 0..3 -xn

# Update /etc/pacman.d/mirrorlist to have the 6 more fastest mirrors

# Make a backup of the original mirrorlist
sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup

# Run the following sed line to uncomment every mirror on backup
sudo sed -i 's/^#Server/Server/' /etc/pacman.d/mirrorlist.backup

# Make the rank and copy it to /etc/pacman.d/mirrorlist to be used
sudo rankmirrors -v -n 6 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist

# Refresh all package lists even if they are considered to be up to date
# and updates the system
sudo pacman -Syyu

# Search for orphaned packages and if found, removes them recursively
if [[ ! -n $(pacman -Qdt) ]]; then
    echo "No orphans to remove."
else
    sudo pacman -Rns $(pacman -Qdtq)
fi

# Removes all the cached packages that are not currently installed
sudo pacman -Sc

# Optimize pacman database of installed packages
sudo pacman-optimize

# Trim the filesystem for deleting bad blocks when using an SSD
sudo fstrim /
