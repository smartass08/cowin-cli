#!/bin/bash
# Anoop S
# shell script to notify and book using cowin-cli


COWIN_CLI="./cowin-cli"

# Interval in seconds
T=15
# centers for grep matching
CENTERS_MATCH='center1|center2|cnter3'
# centers to auto select
CENTERS=""
DISTRICT="district"
STATE="state"
AGE=45
NAMES=""
NO=""
VACCINE=""
DOSE=0
DATE=""
# center type, free or paid, all by default
TYPE=""



notify(){
	osascript -e 'display notification "Center found!" with title "COWIN Update" sound name "Submarine"'
}

schedule(){
	"$COWIN_CLI" -s "$STATE" -d "$DISTRICT" -sc -no "$NO" -m "$AGE" \
	-names "$NAMES" -centers "$CENTERS" -v "$VACCINE" -dose $DOSE   -c "$DATE" -t "$TYPE"   && exit 0 
}


while :
do
	echo "looking for centers.."

	"$COWIN_CLI" -s "$STATE"  -d "$DISTRICT" -m "$AGE" -b -v "$VACCINE" -dose $DOSE -c "$DATE" -t "$TYPE"

	if (( $? == 0  )) 
	then
		notify
		schedule
	fi

	sleep $T
done
