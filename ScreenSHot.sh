#!/bin/sh

# FTP
ftpip= FTP IP Address
ftpport= FTP Port
ftpdir= /path/to/html/directory/here/
ftpuser= FTP User
ftppass= FTP Password
domain= http://yourdomain.com/imagefolder/

string=$(cat /dev/urandom | env LC_CTYPE=C tr -dc 'a-z0-9' | fold -w 5 | head -n 1)
stringkeep=$(echo "$string")

cd ~/Documents/img/

screencapture -s ~/Documents/img/"$stringkeep".png
if grep -ri png .
	then 
	curl -T "$stringkeep".png -u "$ftpuser":"$ftppass" ftp://"$ftpip":"$ftpport"/"$ftpdirectory"
	url=""$domain""$stringkeep".png"
	osascript -e 'display notification "'"$url"'" with title "Screenshot Saved!"'
	echo "$url" | pbcopy
	rm -f ~/Documents/img/*.png
	exit
else
	sleep 0.1
	exit
fi
