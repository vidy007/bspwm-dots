#!/bin/bash

# Linux Screen On - Prevent screen from turning off
# This script disables screen timeout and screen saver

echo "Starting Linux Screen On script..."

# Disable X11 screen saver and DPMS (Display Power Management Signaling)
echo "Disabling X11 screen saver and DPMS..."
xset s off
xset -dpms
xset s noblank

# For GNOME desktop environments
if command -v gsettings &> /dev/null; then
    echo "Configuring GNOME settings..."
    gsettings set org.gnome.desktop.screensaver idle-activation-enabled false
    gsettings set org.gnome.desktop.session idle-delay 0
    gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'
    gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'nothing'
fi

# For KDE Plasma desktop environments
if command -v kwriteconfig5 &> /dev/null; then
    echo "Configuring KDE Plasma settings..."
    kwriteconfig5 --file powermanagementprofilesrc --group AC --group DimDisplay --key idleTime 0
    kwriteconfig5 --file powermanagementprofilesrc --group AC --group DPMSControl --key idleTime 0
    kwriteconfig5 --file powermanagementprofilesrc --group AC --group HandleButtonEvents --key lidAction 0
fi

# For systemd-based systems - inhibit idle
if command -v systemd-inhibit &> /dev/null; then
    echo "Using systemd-inhibit to prevent idle..."
    # This will run in background and prevent idle until the script is killed
    systemd-inhibit --what=idle --who="Linux-Screen-On" --why="Keeping screen active" sleep infinity &
    INHIBIT_PID=$!
    echo "Systemd inhibit running with PID: $INHIBIT_PID"
fi

# Prevent laptop lid from suspending (if running on laptop)
if [ -f "/proc/acpi/button/lid/LID/state" ] || [ -f "/proc/acpi/button/lid/LID0/state" ]; then
    echo "Laptop detected - configuring lid settings..."
    if command -v systemctl &> /dev/null; then
        # Temporarily disable lid switch handling
        sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target
    fi
fi

echo "Screen timeout disabled successfully!"
echo "Your screen will now stay on."
echo ""
echo "To re-enable screen timeout, run: ./screen-off.sh"
echo "To stop this script, press Ctrl+C"

# Keep the script running to maintain the settings
if [ ! -z "$INHIBIT_PID" ]; then
    echo "Press Ctrl+C to stop and restore power management..."
    trap 'echo "Stopping systemd-inhibit..."; kill $INHIBIT_PID 2>/dev/null; exit 0' INT TERM
    wait $INHIBIT_PID
else
    echo "Press Ctrl+C to exit..."
    trap 'exit 0' INT TERM
    # Keep script alive
    while true; do
        sleep 30
        # Refresh X11 settings every 30 seconds
        xset s off
        xset -dpms
        xset s noblank
    done
fi

