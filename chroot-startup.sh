#!/bin/bash
echo
echo "Selecting a user to login too. . ."
sleep 1

echo
echo "Showing users. . ."
sleep 1
for usr in $(ls /home); do
        echo $usr
        sleep .25
done | sed 's:lost+found::g'
sleep 1

echo
read -p "Please select a username from list above: " usr_nme
sleep 1

echo
echo "Running command: exec su - $usr_nme"
sleep 1
echo "After command has run and user is logged in, type: 'bash' to load custom bash profile."
sleep 2
exec su - $usr_nme && /bin/bash
