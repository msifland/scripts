#!/bin/bash
#=====================================================
# This file goes in main home folder with startusb.sh
#=====================================================

echo 'spike' | sudo -S -v
sudo modprobe usbcore
sudo modprobe usb-common
sudo modprobe hid-generic
sudo modprobe hid
sudo modprobe usbnet
sudo modprobe cdc_ether
sudo modprobe rndis_host
sudo modprobe usbserial
sudo modprobe usb-storage
sudo modprobe cdc-acm
sudo modprobe ftdi_sio
sudo modprobe usbip-core
sudo modprobe vhci-hcd
echo $(cat /etc/resolv.conf | grep nameserver | awk '{print $2}')
