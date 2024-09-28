DIR="$HOME/Pictures/Screenshots"
mkdir -p "$DIR"
fname="Screenshot_$(date +%Y%m%d_%H%M%S).png"
OUTPATH="$DIR/$fname"

grim -c -g "$(slurp)" $OUTPATH
wl-copy < $OUTPATH
ACTION=$( \
  dunstify --action="open,Open" \
  --urgency low \
  --timeout 5000 \
  "Screenshot saved" $fname
)

if [[ $ACTION == 2 ]]; then
  xdg-open $DIR
fi
