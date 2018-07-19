#!/bin/bash

set -eou

if [ "$(playerctl status 2>&1)" = "Playing" ]; then
  title="$(exec playerctl metadata xesam:title)"
  artist="$(exec playerctl metadata xesam:artist)"
  echo " $title - $artist"
fi
