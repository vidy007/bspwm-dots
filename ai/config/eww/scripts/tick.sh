#!/bin/sh

while :; do
	set -- $(date "+%I %M %a %b %d %y" | tr A-Z a-z)
	# battery lives in battery.sh (event-driven)
	printf "{\"hour\":\"%s\",\"min\":\"%s\",\"wday\":\"%s\",\"mon\":\"%s\",\"day\":\"%s\",\"year\":\"%s\"}\n" "$@"
	sleep $((60 - $(date +%-S)))
done
