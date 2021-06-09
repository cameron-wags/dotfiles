#!/bin/sh
# vim:foldmethod=marker

if [ $(whoami)  = "root" ]; then
    echo "don't run as root"
    exit 0
fi

# rename host-specific files

# cleanup exclude files
# generate software install lists
source installspec.sh

# File copies

# Software installs from pac.list

# Aur installs from aur.list

# Tailscale maps
echo "Log into TailScale before answering this!"
read -p "Add tailscale IPs to /etc/hosts? [y/N]: " answer
if [ answer != "y" ]; then
    tailscale status | \
    sed -E 's/\s{2,}/ /g' | \
    cut -d' ' -f1,2 | \
    sudo tee -a /etc/hosts
fi
# }}}
