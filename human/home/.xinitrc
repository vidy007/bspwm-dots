xrdb ~/.Xresources
export PATH="$HOME/.local/bin:$PATH"
export MOZ_USE_XINPUT2=1
sxhkd &
export DISPLAY=:0
export XDG_CURRENT_DESKTOP=bspwm
export DESKTOP_SESSION=bspwm
systemctl --user reset-failed 'xdg-*'  # claude
systemctl --user stop 'xdg-desktop-portal*'
dbus-update-activation-environment --systemd DISPLAY XAUTHORITY XDG_CURRENT_DESKTOP DESKTOP_SESSION  # claude
xsettingsd &
~/.local/bin/theme-switch auto
dunst &
xset s 50 10  # claude

command -v xss-lock >/dev/null && xss-lock -n ~/.local/bin/autodim -l -- ~/.local/bin/autolock &  # claude
~/.local/bin/fsinhibit &  # claude
exec bspwm
