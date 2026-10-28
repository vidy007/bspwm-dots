#!/usr/bin/env bash

# case "$1" in
#   "volume")
#     pamixer --get-volume; 
#     pactl subscribe \
#       | grep --line-buffered "Event 'change' on sink " \
#       | while read -r evt; 
#       do pamixer --get-volume | cut -d " " -f1;
#     done
#     ;;
# esac
#
if [ "$1" == "volume" ]; then
    pamixer --get-volume; 
    pactl subscribe \
      | grep --line-buffered "Event 'change' on sink " \
      | while read -r evt; 
      do pamixer --get-volume | cut -d " " -f1; done
fi
