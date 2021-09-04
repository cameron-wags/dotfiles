#!/bin/sh

if [ $(xssstate -s) = "disabled" ]; then
	xset s 300
    notify-send -t 1500 -u normal "CAFFIENE OFF" "GOOD NIGHT"
else
	xset -dpms
	xset s off
    notify-send -t 1500 -u normal "CAFFIENE ON" "NO SLEEPING, OK?"
fi

