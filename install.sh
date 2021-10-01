#!/bin/sh
# vim:foldmethod=marker

die() {
    echo -e "$1"
    exit 1
}

if [ $(whoami)  = "root" ]; then
    die "don't run as root"
fi

ls -al ~/.ssh | grep -qi \.pub || {
    die "Set up a GitHub PAT\nRun: ssh-keygen -t ed25519 -C \"email@example.com\""
}

cd "$HOME/repo/linux-conf"

# Install software & config

echo "Running install spec"
./installspec.sh

read -p "Install spec'd packages? [y/N]: " -n 1 answer
echo ""

if [ "$answer" = "Y" -o "$answer" = "y" ]; then
    cat "pac.list" | sudo pacman -S --needed - || die "pacman failed, maybe fix spec.txt?"

    mkdir -p ~/aur
    cat "aur.list" | ./aur.sh -i -
fi

[ -h ~/.zprofile ] || ln -s ~/.config/shell/profile ~/.zprofile

# Tailscale maps
grep "$(tailscale status | sed -E 's/\s{2,}/ /g' | cut -d' ' -f1,2)" /etc/hosts 2>&1 > /dev/null || {
    echo -e "\nLog into TailScale before answering this!"
    read -p "Add tailscale IPs to /etc/hosts? [y/N]: " -n 1 answer
    echo ""
    if [ "$answer" = "Y" -o "$answer" = "y" ]; then
        tailscale status | \
        sed -E 's/\s{2,}/ /g' | \
        cut -d' ' -f1,2 | \
        sudo tee -a /etc/hosts
    fi
}
