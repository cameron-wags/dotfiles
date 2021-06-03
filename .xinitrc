#!/bin/sh

userresources=$HOME/.config/Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap


if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xrdb -merge $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xrdb -merge "$usermodmap"
fi

#if [ -d /etc/X11/xinit/xinitrc.d ] ; then
#    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
#     [ -x "$f" ] && . "$f"
#    done
#    unset f
#fi

# Key Repeat delay ms and rate Hz
xset r rate 260 60 &

nvidia-settings --load-connfig-only &

# Audio controls in systray
pasystray &

exec awesome

