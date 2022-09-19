#!/bin/bash
# This scripts updates the .conkyrc file with correct network adapter type and name.

# File adapter type name and set variable. Using awk to search second field equal to 00000000 then printing the first field.
#IFACE=$(awk '$2 == 00000000 { print $1 }' /proc/net/route)

# File adapter type name and set variable. Using grep to search a beginning line of 0.0.0.0, reverse that line and cut it then after delimiter(' ') to first field then reverse back and sort to unique(cuts duplicates.)
#IFACE=$(route -n | grep "^0.0.0.0" | rev | cut -d' ' -f1 | rev | sort -u)

#  File adapter type name and set variable. Search first field for 0.0.0.0 then show field 8 and sort to unique(cuts duplicates.)
#IFACE=$(route -n | awk '$1 == "0.0.0.0" { print $8 }' | sort -u)

# File adapter type name and set variable. Search for line with 'state UP' cut at delimiter ':' then show field 2 and remove ':'.
# I find this to be the best example as it does not produce duplicates to cut with 'sort -u'.
cd $HOME
IFACE=$(ip link show | grep "state UP" | cut -d':' -f2 | sed 's#:##' | tr -d " ")
echo $IFACE
# Search conky file for adapter that is listed and set variable.
CONKY_NET=$(grep -o -P '(?<=wireless_essid ) [^ ]*' .conkyrc | tr -d " ")

# This section is looking for wireless connection, if it's there it creates a file for the the .conkyrc to search if_existing then display the wireless info.
HAS_WIRELESS=$(ip link show | grep "wl*")
if [[ $HAS_WIRELESS ]]; then
	touch .conky_has_wireless
	iwgetid > .conky_has_wireless
else
	if [[ -f .conky_has_wireless ]]; then
		rm -f .conky_has_wireless
	fi
fi

# Show variables to user and ask to update
<< Comment
read -p "The current .conkyrc files shows ${ILCOLOR1}$CONKY_NET ${ILRESTORE}as adapter interface, the current PC adapter interface is ${ILCOLOR2}$IFACE${ILRESTORE}. Would you like to go ahead and update? " upd

if [[ "$upd" =~ ^([yY][eE][sS]|[yY])$ ]]; then
Comment
	echo
	echo "Ok updating .conkyrc file. . ."
	sleep 1
	echo
	echo "Backing up original file first. . ."
	cp $HOME/.conkyrc $HOME/.conkyrc.bak
	perl -pi -e "s/$CONKY_NET/$IFACE/g" .conkyrc
	sleep 1
<< Comment
else
	echo
	echo "Ok not updating .conkyrc file now. . ."
	sleep 1
fi
Comment

echo
echo "Done"
