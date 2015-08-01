systemctl --failed

sudo journalctl -p 0..3 -xn

sudo rankmirrors -v /etc/pacman.d/mirrorlist

sudo pacman -Syyu

orphans() {
  if [[ ! -n $(pacman -Qdt) ]]; then
    echo "No orphans to remove."
  else
    sudo pacman -Rns $(pacman -Qdtq)
  fi
}
