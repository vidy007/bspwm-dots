#!/bin/sh
# xkblayout-state has no watch mode: check every 0.3s, print only on change so eww does not redraw
p=
while :; do
	l=$(xkblayout-state print %s)
	[ "$l" != "$p" ] && echo "$l" && p=$l
	sleep 0.3
done
