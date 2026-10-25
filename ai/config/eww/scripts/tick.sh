#!/bin/sh

while :; do
	set -- $(date "+%I %M %a %b %d %y" | tr A-Z a-z)
	printf "{\"hour\":\"%s\",\"min\":\"%s\",\"wday\":\"%s\",\"mon\":\"%s\",\"day\":\"%s\",\"year\":\"%s\",\"bat\":\"%s%%\",\"baticon\":\"%s\"}\n" \
		"$@" "$(cat /sys/class/power_supply/BAT0/capacity)" "$(~/battery --icon)"
	sleep $((60 - $(date +%-S)))
done
