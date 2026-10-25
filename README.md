# bspwm-dots

## Required programs

- **WM / session:** bspwm, sxhkd, startx (xorg-xinit), xrdb, xsetroot, setxkbmap, dbus, systemd (user units), xdg-desktop-portal-gtk
- **Compositor:** picom (v12+, glx backend, animations)
- **Bar:** eww (X11 build), xkblayout-state, pactl + pamixer
- **Launcher / menus:** rofi
- **Notifications:** dunst, libnotify (notify-send)
- **Terminal:** alacritty (kitty is themed too, optional)
- **Wallpaper:** feh
- **GTK / theme:** xsettingsd, glib (gsettings), Colloid GTK theme (Colloid-Catppuccin / Colloid-Dark-Catppuccin, in `human/themes`), Colloid icon theme with the Catppuccin scheme (Colloid-Catppuccin-Light / -Dark, https://github.com/vinceliuice/Colloid-icon-theme), GoogleDot Rose Pine cursor (in `human/icons`)
- **Lock screen:** xsecurelock, python3, PyGObject (Gtk 3, Gdk, GdkX11, GdkPixbuf, Pango, PangoCairo), playerctl
- **Workspace switching:** bspwm-slidefx
- **Screenshots:** maim, xclip, xdotool
- **Misc autostart:** udiskie, copyq, brightnessctl
- **Fonts:** BlexMono Nerd Font, IBM Plex Mono, IBM Plex Serif, Font Awesome 6 Free

## Written from scratch by Claude

- `local/bin/lockclock` — xsecurelock saver: clock, date and window count in the current theme
- `local/bin/theme-switch` — light/dark switch for every themed config by palette
- `local/bin/theme-sun` — prints light/dark by sunrise/sunset for LAT, LON
- `local/bin/picom-mode` — switches picom between the full and the light config
- `config/systemd/user/theme-auto.service`, `theme-auto.timer` — runs `theme-switch auto` every 5 minutes
- `config/eww/scripts/tick.sh` — per-minute clock and battery feed for the bar
- `config/eww/scripts/layout.sh` — keyboard layout feed for the bar
- `config/eww/scripts/fullscreen-hide.sh` — hides the bar over fullscreen windows
- `config/picom-light.conf` — picom without animations
- `config/lockclock.conf` — lockscreen fonts
- `config/xdg-desktop-portal/portals.conf` — gtk portal backend

## Install notes and known issues

Copy `ai/` and `human/` into `$HOME`: `config/` → `~/.config`, `local/` → `~/.local`, `themes/` → `~/.themes`, `icons/` → `~/.icons`, `home/*` → `~`.

- `~/.local/bin` must be in `$PATH`: bspwmrc and sxhkdrc call `picom-mode` without a full path, so without it picom does not start.
- The session starts via `startx` (`~/.xinitrc`); a display manager skips xsettingsd, dunst and the theme setup.
- The eww bar opens on the first bspwm event (`fullscreen-hide.sh`), not right at login.
- GTK4 apps stay unthemed: link `~/.config/gtk-4.0/{gtk.css,gtk-dark.css,assets}` to `~/.themes/Colloid-Dark-Catppuccin/gtk-4.0/`.
- Enable the auto theme: `systemctl --user enable --now theme-auto.timer`.
- Set your coordinates in `~/.local/bin/theme-sun` (default: New York, `40.71, -74.01`).
- Create `~/Pictures/Screenshots` for the screenshot menu.
- Harmless errors: bspwmrc calls `tilt`, `~/touchpad`, `tlp-refresh` (not included); sxhkd binds for `tilt`, `tpspeed`, `tpreset`, `touchpad_toggle.sh` do nothing.
- The rofi power menu "lock" looks for betterlockscreen/i3lock; the lock screen is on `XF86Display` (F7).
- `audio.sh toggle` uses specific sound devices; the battery widget reads `BAT0`.
- `.xinitrc` stops portals with `systemctl --user`; on non-systemd systems this prints errors but the session starts.
