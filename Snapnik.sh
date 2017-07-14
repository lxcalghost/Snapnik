cd ~/Desktop
string=$(cat /dev/urandom | env LC_CTYPE=C tr -dc 'a-z0-9' | fold -w 6 | head -n 1)
stringkeep="$string"
screencapture -t jpg -s ~/Desktop/"$stringkeep".jpg
if find . -maxdepth 1 | grep -i '[.]jpe\?g$'
	then
	convert ~/Desktop/"$stringkeep".jpg -resize '85%' "$stringkeep".1.jpg
	curl --silent -F "encrypt=true" -F "saveKey=true" -F file=""@$stringkeep".1.jpg" "https://api.teknik.io/v1/Upload" > .snap
	sed -ne 's/.*\(http[^"]*\).*/\1/p' < .snap > .snap0
        url=$(sed 's/upload/u/g' .snap0)
        osascript -e 'display notification "'"$url"'" with title "Screenshot Saved!"'
	echo "$url" | pbcopy
	rm -f "$stringkeep".jpg "$stringkeep".1.jpg
	exit
else
	sleep 0.1
	exit
fi
