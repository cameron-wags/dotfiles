#!/bin/dash

if [ $(xssstate -s) = "disabled" ]; then
	xset s 300
else
	xset -dpms
	xset s off
fi

