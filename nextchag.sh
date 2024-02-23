# Shell script to print the next Yom Tov
# Uses hebcal
#!/bin/sh

TODAY=$(date -d 'today' +%s)						# Today's date as UNIX timestamp at midnight
NEXTYEAR=$(date -d "next year" +%Y)					# Next year in full
while IFS= read -r line; do						# Loop through list
        DATE=$(echo "$line" | awk '{print $1}')				# Get first word of each line
        DATE_UNIX=$(date -d "$DATE" +%s)				# Convert first of each line to UNIX timestamp
        CHAG=$(echo "$line" | sed 's/^[^ ]* //')			# Get rest of line after first white space
	if [[ "$line" == *Erev* || "$line" == "*C''M*" || "$line" == "*Hoshana Raba*" ]]; then
		continue
	fi
        if [[ $DATE_UNIX -ge $TODAY ]]; then				# Check if unix timestamp for chag is greater than unix timestamp for today
                echo "The next chag is $CHAG."				# Echo next chag to standard output
                exit 0
        fi
done < <(hebcal --chag-only && hebcal --chag-only $NEXTYEAR)		# Feed list of chagim for this year and next year into while loop
