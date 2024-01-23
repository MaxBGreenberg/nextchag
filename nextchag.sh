# Shell script to print the next Yom Tov 
#!/bin/sh

TODAY=$(date -d 'today' +%s)
NEXTYEAR=$(date -d "next year" +%Y)
while IFS= read -r line; do
        DATE=$(echo "$line" | awk '{print $1}')
        DATE_UNIX=$(date -d "$DATE" +%s)
        CHAG=$(echo "$line" | sed 's/^[^ ]* //')
        if [[ $DATE_UNIX -ge $TODAY ]]; then
                echo "The next chag is $CHAG."
                exit 0
        fi
done
