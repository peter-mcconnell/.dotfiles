#!/bin/sh

BATTERY=/sys/class/power_supply/BAT0
STATE="$(grep "POWER_SUPPLY_STATUS=" $BATTERY/uevent | cut -d '=' -f2)"
if [ "$STATE" = "Discharging" ]; then
  REM="$(grep "POWER_SUPPLY_CHARGE_NOW=" $BATTERY/uevent | cut -d '=' -f2)"
  FULL="$(grep "POWER_SUPPLY_CHARGE_FULL=" $BATTERY/uevent | cut -d '=' -f2)"
  PER=$(( REM * 100 / FULL ))
  if [ $PER -le "50" ]; then
    color="warning"
    if [ $PER -le "20" ]; then
      color="error"
    fi
    DISPLAY=:0 i3-msg "exec i3-nagbar -t $color -m \"battery at ${PER}%\" -f 'pango:Hack 14'"
  fi
fi
