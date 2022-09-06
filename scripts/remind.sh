#!/bin/bash
# Make a new reminder via terminal script
# args: remind <title> <date> <time>

osascript - "$1" "$2" "$3" <<END
on run argv
    set stringedAll to date (item 2 of argv & " " & item 3 of argv)
    tell application "Reminders"
        make new reminder with properties {name:item 1 of argv, due date:stringedAll}
    end tell
end run
END
