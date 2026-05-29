#!/bin/bash
DIR="$HOME/Pictures/Screenshots"
mkdir -p "$DIR"
fname="Screenshot_$(date +%Y%m%d_%H%M%S).png"
OUTPATH="$DIR/$fname"

if GEOM=$(slurp 2>/dev/null); then
  w=$(echo "$GEOM" | grep -oP '\d+(?=x)' | tail -1)
  h=$(echo "$GEOM" | grep -oP '(?<=x)\d+')
  if [[ "$w" -le 2 && "$h" -le 2 ]]; then
    grim -c "$OUTPATH"
  else
    grim -c -g "$GEOM" "$OUTPATH"
  fi
else
  grim -c "$OUTPATH"
fi

wl-copy -t image/png < "$OUTPATH"

ACTION=$(dunstify \
  --action="edit,Edit" \
  --urgency low \
  --timeout 5000 \
  "Screenshot saved" "$fname")

case "$ACTION" in
  "edit") swappy -f "$OUTPATH" ;;
esac
