# Test for using the rpi 0 as a serial-to-HID keyboard adapter

- the rpi0 is configured into gadget mode
- it starts a node js app that waits to recieve commands over serial port ttyS0 - see `serial-send.js` for an example
- when it recieves the keys it then uses `send_chars.sh` to emulate the keyboard presses