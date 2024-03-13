#!/usr/bin/env bash

# KDE's default terminal emulator supports profiles, you can create one in 
# Settings > Manage Profiles. You can select a dark or light theme in 
# Appearance > Color scheme and font. The following script iterates over all
# instances of Konsole und changes the profile of all sessions. This is necessary,
# if there are multiple tabs in one of the Konsole instances.
# Reference: https://docs.kde.org/stable5/en/konsole/konsole/konsole.pdf

# get all running konsole instances
KONSOLEPIDS=($(pidof konsole))
for i in "${KONSOLEPIDS[@]}"
    do
        # get number of sessions this particular instance has
        CURRENTSESSIONCOUNT=$(qdbus org.kde.konsole-$i /Windows/1 sessionCount)
        for x in $(seq 1 $CURRENTSESSIONCOUNT)
            do 
                # change profile through dbus message
                qdbus org.kde.konsole-$i /Sessions/$x setProfile "Breath-light"
            done
    done
