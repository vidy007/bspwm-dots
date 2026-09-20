#!/usr/bin/env bash

#VIBECODED

current_desktop() {
  bspc query -D -d focused --names
}

current_desktop

# И обновлять при изменениях рабочих столов
bspc subscribe desktop | while read event
do
  current_desktop
done
