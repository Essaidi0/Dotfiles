#!/bin/sh

# Send a notification when the laptop is plugged in/unplugged
# Add the following to /etc/udev/rules.d/60-power.rules (replace USERNAME with your user)

# ACTION=="change", SUBSYSTEM=="power_supply", ATTR{type}=="Mains", ATTR{online}=="0", ENV{DISPLAY}=":0", ENV{XAUTHORITY}="/home/USERNAME/.Xauthority" RUN+="/usr/bin/su USERNAME -c '/home/USERNAME/.local/bin/battery-charging discharging'"
# ACTION=="change", SUBSYSTEM=="power_supply", ATTR{type}=="Mains", ATTR{online}=="1", ENV{DISPLAY}=":0", ENV{XAUTHORITY}="/home/USERNAME/.Xauthority" RUN+="/usr/bin/su USERNAME -c '/home/USERNAME/.local/bin/battery-charging charging'"


export XAUTHORITY=~/.Xauthority
export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"

BATTERY_STATE=$1
BATTERY_LEVEL=$(acpi -b | grep "Battery 0" | grep -P -o '[0-9]+(?=%)')

# Verifica se a variável BATTERY_STATE está definida corretamente
if [ "$BATTERY_STATE" -eq 1 ]; then
    /usr/bin/notify-send "Charging" "${BATTERY_LEVEL}% of battery charged." -u low -i ~/.local/bin/battery-charging-resized.png -t 5000 -r 9991
elif [ "$BATTERY_STATE" -eq 0 ]; then
    /usr/bin/notify-send "Discharging" "${BATTERY_LEVEL}% of battery remaining." -u low -i ~/.local/bin/battery-alert-resized.png -t 5000 -r 9991
else
    echo "Invalid BATTERY_STATE: $BATTERY_STATE"
fi
 case "$BATTERY_STATE" in
 	"charging") BATTERY_CHARGING="Charging" ; BATTERY_ICON="charging" ;;
 	"discharging") BATTERY_CHARGING="Disharging" ; BATTERY_ICON="discharging" ;;
 esac

# # Send notification
 notify-send "${BATTERY_CHARGING}" "${BATTERY_LEVEL}% of battery charged." -u normal -i "battery-${BATTERY_ICON}" -t 5000 -r 9991
