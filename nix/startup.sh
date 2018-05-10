
chromium http://localhost:9000 &
sleep 2
wmctrl -r Chromium -t add,maximized_vert,maximized_horz
wmctrl -r Chromium -t 1

xfce4-terminal -T ghcid --working-directory=~/reflex-workshop --command=ghcid
sleep 2
wmctrl -r ghcid -t add,maximized_vert,maximized_horz
wmctrl -r ghcid -t 2
