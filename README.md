<h1 align="center">my rice fields</h1>

### first things first
i've been baking this rice for probably a year or two, and recently i got into uni and started *vibecoding* a lot, mostly due to extreme lack of free time. please don't judge me for this, i'm planning to do a recode of everything claude did for this repo so you won't have to suffer from ai slop, but until then, here's a breakdown:

|           | my work | claude's work |
| --------- | ------- | ------------- |
| files     | 35      | 18            |
| LOC       | 1938    | 948           |

the cursor is a googledot theme edited by me. the gtk theme came from the goat fausto-korpsvart and was edited only by claude (idk how to make themes).

a few words about dir structure:
- /ai/ holds not yet reviewed slopcode; it's tested but needs a review and rewrite
- /human/ holds mostly human-made code, alongside heavily edited slop that eventually turned into normal code

not all the files in /ai/ are considered complete slop -- some are placed there out of caution, and are often moved to /human/ soon after. 

the sloppiest scripts here at the moment are `lockclock` (a custom xsecurelock saver with its own UI) and `theme-switch` (the light/dark switcher) -- both work, both are first in line for a recode

### showcase
coming soon i swear

### required packages (generic)
```
bspwm sxhkd xorg-xinit xrdb xsetroot setxkbmap dbus xdg-desktop-portal-gtk picom eww xkblayout-state
pamixer rofi dunst libnotify alacritty feh xsettingsd dconf xsecurelock xss-lock python3 pygobject playerctl bspwm-slidefx maim xclip xdotool udiskie copyq brightnessctl util-linux
```
fonts:
```
blexmono-nerd-font ibm-plex-mono ibm-plex-serif font-awesome-6-free golos-text
```
taken from google fonts: gravitas one (lock screen only)

### quickstart
1. copy contents of /ai/ and /human/ into your homedir: 

make a backup of your configs before running the command below
```
mkdir -p ~/.config ~/.local ~/.themes ~/.icons
for d in human ai; do
    cp -r $d/home/. ~/
    cp -r $d/config/. ~/.config/
    cp -r $d/local/. ~/.local/
done
cp -r ai/themes/. ~/.themes/
cp -r human/icons/. ~/.icons/
```
2. enable auto theme timer: 
```
systemctl --user enable --now theme-auto.timer
``` 
(openrc service coming soon)
3. set your city coords in `~/.local/bin/theme-sun` (default: nyc)
4. review and edit .config/sxhkd/sxhkdrc (or leave as-is if you're fine with the binds)

### some notes before you go
- the session starts via `startx` (`~/.xinitrc`); a display manager skips xsettingsd, dunst and the theme setup.
- gtk4/libadwaita apps get the theme through `~/.config/gtk-4.0/{gtk.css,gtk-dark.css,assets}`; `theme-switch` links them to the current theme, so run it once after installing
- sxhkd binds for `tilt`, `tpspeed` and `tpreset` do nothing -- i'm not planning to post thinkpad-centered scripts here as they're useless for other machines
- the rofi power menu "lock" looks for betterlockscreen/i3lock; the lock screen is on `XF86Display` (f7)
- the screen locks after 60 s idle (dims at 50 s) and before suspend via `xss-lock` (`autodim`, `autolock`); a fullscreen firefox/mpv window holds it off (`fsinhibit`)
- the battery widget reads `BAT0`
- `.xinitrc` stops portals with `systemctl --user`; on non-systemd systems this prints errors but the session starts (openrc variant coming soon)
