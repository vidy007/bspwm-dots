#!/bin/sh
# Battery on events: udev power_supply uevents (charger plugged/unplugged, status change) redraw at once;
# capacity creeps without reliable uevents, so also re-read every 30s. Print only on change so eww does not redraw.
p=
emit() {
	s=$(printf '{"bat":"%s%%","icon":"%s"}' "$(cat /sys/class/power_supply/BAT0/capacity)" "$(~/battery --icon)")
	[ "$s" != "$p" ] && echo "$s" && p=$s
}
emit
{
	udevadm monitor --udev --subsystem-match=power_supply &
	while :; do sleep 30; echo tick; done
} | while read -r _; do
	# status in sysfs settles a moment after the AC event
	sleep 0.5
	emit
done
