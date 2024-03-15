#!/usr/bin/env bash

# get all running yakuake sessions
sessionList=$(qdbus org.kde.yakuake /yakuake/sessions sessionIdList)
sessionCount=$(($(echo $sessionList | tr -cd , | wc -c) + 1))
for x in $(seq 1 $sessionCount); do
	# change profile through dbus message
	qdbus org.kde.yakuake /Sessions/$x setProfile "Light"
done

# change default profile
sed -i 's/DefaultProfile.*/DefaultProfile=Light.profile/' $HOME/.config/yakuakerc
