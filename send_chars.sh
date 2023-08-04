#!/bin/bash

# Test the necessary keys
for i in {1..15}; do
    cat <<EOF | ./hid_gadget_test /dev/hidg0 keyboard > /dev/null
    --del
EOF

    sleep 1
done

    cat <<EOF | ./hid_gadget_test /dev/hidg0 keyboard > /dev/null
    --return
EOF

sleep 1

for i in {1..5}; do

    cat <<EOF | ./hid_gadget_test /dev/hidg0 keyboard > /dev/null
    --right
EOF

done
