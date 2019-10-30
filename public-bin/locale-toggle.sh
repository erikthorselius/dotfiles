#!/usr/bin/env bash
locale=`xkblayout-state print %s | awk '{print toupper($0)}'`
echo $locale >> /tmp/file.tmp
if [ "$locale" == "US" ]; then
  setxkbmap se
  pkill -RTMIN+1 i3blocks
else 
  setxkbmap us
  pkill -RTMIN+1 i3blocks 
fi
