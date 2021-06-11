#!/bin/sh
# vim:foldmethod=marker

if [ $(whoami)  = "root" ]; then
    echo "don't run as root"
    exit 0
fi

ls -al ~/.ssh | grep -qi \.pub || {
    echo -e "Set up a GitHub PAT\nRun: ssh-keygen -t ed25519 -C \"email@example.com\""
    exit 1
}

# Install software & config
read -p "Install from spec? [y/N]: " -n 1 answer
echo ""
[ "$answer" = "Y" -o "$answer" = "y" ] && source installspec.sh

ln -s ~/.config/shell/profile ~/.zprofile

# Tailscale maps
echo -e "\nLog into TailScale before answering this!"
read -p "Add tailscale IPs to /etc/hosts? [y/N]: " -n 1 answer
echo ""
if [ "$answer" = "Y" -o "$answer" = "y" ]; then
    tailscale status | \
    sed -E 's/\s{2,}/ /g' | \
    cut -d' ' -f1,2 | \
    sudo tee -a /etc/hosts
fi
