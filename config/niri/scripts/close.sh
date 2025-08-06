#! /bin/sh
if [ "$(niri msg focused-window | grep "App ID" | sed -n 's/.*"\(.*\)".*/\1/p')" = "firefox" ]; then
    echo "is firefox"
else
    niri msg action close-window
fi

