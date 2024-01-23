const { SerialPort } = require('serialport')


const port = new SerialPort({ path: '/dev/ttyUSB0', baudRate: 115200, autoOpen: true })
port.write('--f10 \r\n');

