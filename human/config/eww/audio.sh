#!/usr/bin/env bash

case "$1" in
  "symbol")
    pactl subscribe | grep --line-buffered "Event 'change' on client" | while read -r; do
      case "$(pactl get-default-sink)" in
        *Arctis_9*) echo "";;
        #*Arctis_9*) echo "";;
        *)          echo "";;
      esac
    done
    ;;
  "volume")
    pamixer --get-volume; 
    pactl subscribe \
      | grep --line-buffered "Event 'change' on sink " \
      | while read -r evt; 
      do pamixer --get-volume | cut -d " " -f1;
    done
    ;;
esac
