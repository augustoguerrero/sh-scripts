# Check if any systemd services have entered in a failed state
systemctl --failed

# Look for high priority errors in the systemd journal
sudo journalctl -p 0..3 -xn

# Update /etc/pacman.d/mirrorlist to have the 6 more fastest mirrors

# Make a backup of the original mirrorlist
sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup

# Optionally run the following sed line to uncomment every mirror on backup
sudo sed -i 's/^#Server/Server/' /etc/pacman.d/mirrorlist.backup

# Make the rank and copy it to /etc/pacman.d/mirrorlist to be used
sudo rankmirrors -n 6 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist

# Refresh all package lists even if they are considered to be up to date
sudo pacman -Syyu

# Recursively search for orphaned packages and if found, removes them
orphans() {
  if [[ ! -n $(pacman -Qdt) ]]; then
    echo "No orphans to remove."
  else
    sudo pacman -Rns $(pacman -Qdtq)
  fi
}

# Calling the function
orphans
