#!/bin/bash

# Linux Screen Off - Restore screen timeout and power management
# This script re-enables screen timeout and screen saver

echo "Starting Linux Screen Off script..."

# Re-enable X11 screen saver and DPMS (Display Power Management Signaling)
echo "Re-enabling X11 screen saver and DPMS..."
xset s on
xset +dpms
xset s blank

# Set reasonable defaults
xset s 300  # Screen saver after 5 minutes
xset dpms 600 900 1200  # Standby after 10min, suspend after 15min, off after 20min

# For GNOME desktop environments
if command -v gsettings &> /dev/null; then
    echo "Restoring GNOME settings..."
    gsettings set org.gnome.desktop.screensaver idle-activation-enabled true
    gsettings set org.gnome.desktop.session idle-delay 300
    gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'suspend'
    gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'suspend'
fi

# For KDE Plasma desktop environments
if command -v kwriteconfig5 &> /dev/null; then
    echo "Restoring KDE Plasma settings..."
    kwriteconfig5 --file powermanagementprofilesrc --group AC --group DimDisplay --key idleTime 300000
    kwriteconfig5 --file powermanagementprofilesrc --group AC --group DPMSControl --key idleTime 600000
    kwriteconfig5 --file powermanagementprofilesrc --group AC --group HandleButtonEvents --key lidAction 1
fi

# Re-enable systemd power management targets
if command -v systemctl &> /dev/null; then
    echo "Re-enabling systemd power management..."
    sudo systemctl unmask sleep.target suspend.target hibernate.target hybrid-sleep.target
fi

# Kill any running systemd-inhibit processes from screen-on.sh
echo "Stopping any running screen-on inhibitors..."
pkill -f "systemd-inhibit.*Linux-Screen-On" 2>/dev/null

echo "Screen timeout and power management restored successfully!"
echo "Your screen will now turn off according to system settings."
echo "Default settings: Screen saver after 5 minutes, DPMS after 10/15/20 minutes"

