#!/bin/sh
# vim:foldmethod=marker

if [ $(whoami)  = "root" ]; then
    echo "don't run as root"
    exit 0
fi

# Stock software {{{
sudo pacman -S \
adobe-source-code-pro-fonts \
awesome \
calibre \
cmake \
cpupower \
curl \
discord \
dolphin \
ffmpeg \
ffmpegthumbs \
firefox \
fontconfig \
freetype2 \
gimp \
git \
git-lfs \
gnupg \
go \
graphviz \
gzip \
hicolor-icon-theme \
htop \
imagemagick \
jdk-openjdk \
jre-openjdk \
jre-openjdk-headless \
jre11-openjdk \
jre11-openjdk-headless \
kitty \
kitty-terminfo \
libreoffice-fresh \
man-db \
mpv \
neovim \
nodejs \
noto-fonts \
noto-fonts-cjk \
npm \
obs-studio \
openssh \
openssl \
pasystray \
perl-term-readkey \
pulseaudio \
pulseaudio-alsa \
python \
qbittorrent \
qemu \
reflector \
rxvt-unicode \
rxvt-unicode-terminfo \
sudo \
tailscale \
ttf-cascadia-code \
ttf-hack \
ttf-joypixels \
ttf-liberation \
unzip \
vim \
vim-runtime \
vlc \
xbindkeys \
youtube-dl \
zip \
zsh \
zsh-autosuggestions \
zsh-completions \
zsh-history-substring-search \
zsh-syntax-highlighting
# }}}

# Copy your stuff {{{
cp -fp bin/* ~/bin/
chmod +x ~/bin/*
cp -f .zshenv .zprofile .zshrc .gitconfig ~/
cp -fp .config/awesome/* ~/.config/awesome/
cp -fp .config/nvim/* ~/.config/nvim/

# Tailscale maps
sudo echo -e "100.125.109.42  euclid\n100.82.84.13    apex\n100.82.157.35   vertex\n" >> /etc/hosts
# }}}

# Aur installs {{{
~/bin/aur -i https://aur.archlinux.org/gitkraken.git
~/bin/aur -i https://aur.archlinux.org/smenu-git.git
~/bin/aur -i https://aur.archlinux.org/visual-studio-code-bin.git
# }}}

