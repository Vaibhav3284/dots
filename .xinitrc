#!/bin/sh

sysresources=/home/pwnguin/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

if [ -f $sysresources ]; then
    	xrdb -merge $sysresources
    fi

if [ -f $sysmodmap ]; then
    	xmodmap $sysmodmap
    fi

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 	for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
 	 [ -x "$f" ] && . "$f"
  done
 unset f
 fi

(conky | while read LINE; do xsetroot -name "$LINE"; done) &
exec slstatus &
exec feh --bg-fill ~/Pictures/wallhaven-21d6g9_1920x1080.png &
stalonetray &
exec dwm
