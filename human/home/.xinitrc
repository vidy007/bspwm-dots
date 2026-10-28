xrdb ~/.Xresources
export PATH="$HOME/.local/bin:$PATH"
export MOZ_USE_XINPUT2=1
sxhkd &
export DISPLAY=:0
export XDG_CURRENT_DESKTOP=bspwm
export DESKTOP_SESSION=bspwm
systemctl --user reset-failed 'xdg-*'
systemctl --user stop 'xdg-desktop-portal*'
dbus-update-activation-environment --systemd DISPLAY XAUTHORITY XDG_CURRENT_DESKTOP DESKTOP_SESSION
xsettingsd &
~/.local/bin/theme-switch auto
dunst &
exec bspwm
