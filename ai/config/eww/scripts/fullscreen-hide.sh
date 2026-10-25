#!/bin/sh
# Close the eww bar while the focused desktop has a fullscreen window, reopen otherwise.
# shortcut: assumes one monitor with the bar; on multi-monitor check the bar's monitor instead of focused.
shown=
bspc subscribe node_state node_remove node_transfer node_add desktop_focus | while read -r _; do
	if bspc query -N -n .fullscreen.window -d focused > /dev/null; then want=no; else want=yes; fi
	[ "$want" = "$shown" ] && continue
	shown=$want
	if [ "$want" = yes ]; then eww open bar_1; else eww close bar_1; fi
done
