#!/bin/bash
echo "Sending keys: $1"

cat <<EOF | ./hid_gadget_test /dev/hidg0 keyboard > /dev/null
     $1
EOF