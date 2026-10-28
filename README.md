# bspwm-dots

## First things first
— *you committed "human-made" files with description "made with some help of Claude". Are you lying?*

No, I'm not. Commit for the `human` and `ai` dirs was created by Claude. The 905 files in the `human` directory were not. Everything that's Ai-assisted is located in the corresponding `ai` folder.

## Required programs

- **WM / session:** bspwm, sxhkd, startx (xorg-xinit), xrdb, xsetroot, setxkbmap, dbus, systemd (user units), xdg-desktop-portal-gtk
- **Compositor:** picom (v12+, glx backend, animations)
- **Bar:** eww (X11 build), xkblayout-state, pactl + pamixer
- **Launcher / menus:** rofi
- **Notifications:** dunst, libnotify (notify-send)
- **Terminal:** alacritty (kitty is themed too, optional)
- **Wallpaper:** feh
- **GTK / theme:** xsettingsd, dconf, Rose Pine GTK theme (Rosepine-Pink-Light / -Dark, built from https://github.com/Fausto-Korpsvart/Rose-Pine-GTK-Theme with local tweaks, in `human/themes`), Colloid icon theme, orange accent with the Catppuccin scheme (Colloid-Orange-Catppuccin-Light / -Dark, https://github.com/vinceliuice/Colloid-icon-theme), GoogleDot Rose Pine cursor (in `human/icons`)
- **Lock screen:** xsecurelock, python3, PyGObject (Gtk 3, Gdk, GdkX11, GdkPixbuf, Pango, PangoCairo), playerctl
- **Workspace switching:** bspwm-slidefx
- **Screenshots:** maim, xclip, xdotool
- **Misc autostart:** udiskie, copyq, brightnessctl
- **Fonts:** BlexMono Nerd Font, IBM Plex Mono, IBM Plex Serif, Font Awesome 6 Free, Golos Text (GTK)

## Written from scratch by Claude

- `local/bin/lockclock` — xsecurelock saver: clock, date and window count in the current theme
- `local/bin/theme-switch` — light/dark switch for every themed config by palette, plus the GTK theme, icons and cursor (GoogleDot Rose Pine / Rose Pine Dawn); edits staged copies, then swaps them in and reloads everything at once, so apps switch together
- `local/bin/theme-sun` — prints light/dark by sunrise/sunset for LAT, LON
- `local/bin/picom-mode` — switches picom between the full and the light config
- `config/systemd/user/theme-auto.service`, `theme-auto.timer` — runs `theme-switch auto` every 5 minutes
- `config/eww/scripts/tick.sh` — per-minute clock feed for the bar
- `config/eww/scripts/battery.sh` — battery feed for the bar: redraws on udev power_supply events (charger plugged/unplugged), re-reads capacity every 30s
- `config/eww/scripts/layout.sh` — keyboard layout feed for the bar
- `config/eww/scripts/fullscreen-hide.sh` — hides the bar over fullscreen windows
- `config/picom-light.conf` — picom without animations
- `config/lockclock.conf` — lockscreen fonts
- `config/xdg-desktop-portal/portals.conf` — gtk portal backend

## Install notes and known issues

Copy `ai/` and `human/` into `$HOME`: `config/` → `~/.config`, `local/` → `~/.local`, `themes/` → `~/.themes`, `icons/` → `~/.icons`, `home/*` → `~`.

- The session starts via `startx` (`~/.xinitrc`); a display manager skips xsettingsd, dunst and the theme setup.
- GTK4/libadwaita apps get the theme through `~/.config/gtk-4.0/{gtk.css,gtk-dark.css,assets}`; `theme-switch` links them to the current theme, so run it once after installing.
- Enable the auto theme: `systemctl --user enable --now theme-auto.timer`.
- Set your coordinates in `~/.local/bin/theme-sun` (default: New York, `40.71, -74.01`).
- sxhkd binds for `tilt`, `tpspeed` and `tpreset` do nothing.
- The rofi power menu "lock" looks for betterlockscreen/i3lock; the lock screen is on `XF86Display` (F7).
- The battery widget reads `BAT0`.
- `.xinitrc` stops portals with `systemctl --user`; on non-systemd systems this prints errors but the session starts.
