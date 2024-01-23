# Shell script to print the next Yom Tov 
#!/bin/sh

TODAY=$(date '+%m %d %Y')					# Set variable TODAY to today's date in format taken by hebcal
NEXTYEAR=$(date -d "next year" +%Y)				# Set variable NEXTYEAR to the comming year written out in full
CHAGIM=$(hebcal --chag-only && hebcal --chag-only $NEXTYEAR)	# Set variable CHAGIM to a list of all Yom Tovs and erev Yom Tovs of the current and coming years and their dates

while read -r line; do
	CHAGDATE=$(echo "$line" | awk '{print $1}' | sed 's#/#''#g')
	if [[ "$CHAGDATE" -ge "$TODAY" ]]; then
		echo $1
		break
	fi
done <<< "$CHAGIM"
