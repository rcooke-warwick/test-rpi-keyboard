#!/bin/bash

# This script is based on the example at
# https://randomnerdtutorials.com/raspberry-pi-zero-usb-keyboard-hid/

if [ -e /dev/hidg0 ]; then
    echo "USB Gadget already initialized"
else
    modprobe dwc2
    modprobe libcomposite

    mkdir -p /config
    mount -t configfs none /config
    mkdir -p /config/usb_gadget/keyboard_simulator
    cd /config/usb_gadget/keyboard_simulator
    echo 0x1d6b > idVendor # Linux Foundation
    echo 0x0104 > idProduct # Multifunction Composite Gadget
    echo 0x0100 > bcdDevice # v1.0.0
    echo 0x0200 > bcdUSB # USB2
    mkdir -p strings/0x409
    echo "0123401234abcdef" > strings/0x409/serialnumber
    echo "balena" > strings/0x409/manufacturer
    echo "balena keyboard simulator" > strings/0x409/product
    mkdir -p configs/c.1/strings/0x409
    echo "Config 1: ECM network" > configs/c.1/strings/0x409/configuration
    echo 250 > configs/c.1/MaxPower
    mkdir -p functions/hid.usb0
    echo 1 > functions/hid.usb0/protocol
    echo 1 > functions/hid.usb0/subclass
    echo 8 > functions/hid.usb0/report_length
    echo -ne \\x05\\x01\\x09\\x06\\xa1\\x01\\x05\\x07\\x19\\xe0\\x29\\xe7\\x15\\x00\\x25\\x01\\x75\\x01\\x95\\x08\\x81\\x02\\x95\\x01\\x75\\x08\\x81\\x03\\x95\\x05\\x75\\x01\\x05\\x08\\x19\\x01\\x29\\x05\\x91\\x02\\x95\\x01\\x75\\x03\\x91\\x03\\x95\\x06\\x75\\x08\\x15\\x00\\x25\\x65\\x05\\x07\\x19\\x00\\x29\\x65\\x81\\x00\\xc0 > functions/hid.usb0/report_desc
    ln -s functions/hid.usb0 configs/c.1/
    ls /sys/class/udc > UDC
fi

# # Don't exit the process
# while true; do
#     sleep 1
# done
node ./lib/index.js
