# xinput set-prop 10 368 0.4 &
# dispwin /usr/share/color/icc/colord/tn.icc
xrdb ~/.Xresources
# XInput2 lets Firefox get touchpad pinch (Miro zoom) and smooth scroll
export MOZ_USE_XINPUT2=1
sxhkd &
# exec i3
# exec dwm
# exec awesome
# Before starting bspwm
export DISPLAY=:0
export XDG_CURRENT_DESKTOP=bspwm
export DESKTOP_SESSION=bspwm
# Use the systemd user bus (one bus, one set of portals) and share the env with activated services
# Portals survive X restarts in the systemd user manager and keep stale state; let them respawn on demand
systemctl --user reset-failed 'xdg-*'
systemctl --user stop xdg-desktop-portal.service xdg-desktop-portal-gtk.service xdg-desktop-portal-xapp.service xdg-desktop-portal-gnome.service
dbus-update-activation-environment --systemd DISPLAY XAUTHORITY XDG_CURRENT_DESKTOP DESKTOP_SESSION
xsettingsd &
~/.local/bin/theme-switch auto
dunst &
exec bspwm
