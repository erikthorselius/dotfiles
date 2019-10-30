#!/usr/bin/env bash
~/.public-bin/i3subscribe window | grep --line-buffered window:focus | \
while read line; do
  id="$(xprop -root _NET_ACTIVE_WINDOW | awk '{print $5}')"
  case "$(xprop -id "$id" WM_CLASS | cut -d\" -f4)" in
        Google-chrome-beta)        kb=se ;;
	Mattermost)                kb=se ;;
        *)	                   kb=us ;;
  esac
  setxkbmap "$kb"
  pkill -RTMIN+1 i3blocks
done
