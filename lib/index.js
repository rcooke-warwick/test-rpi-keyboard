const { SerialPort } = require('serialport')
const { ReadlineParser } = require('@serialport/parser-readline')
const util = require('util');
const exec = util.promisify(require('child_process').exec);

// Specify the serial port path (you can find this in your system's device manager)
const portPath = process.env.SERIAL_PORT || '/dev/ttyS0'; // Change this to your actual serial port path

const serialPort = new SerialPort({path: portPath, baudRate: 115200, autoOpen: true }); // Adjust baudRate if needed

// Create a parser to read lines from the serial port
const parser = serialPort.pipe(new ReadlineParser({ delimiter: `\r\n` }));

// Event handler for incoming data
parser.on('data', async(data) => {
  console.log(`Received command: ${data}`);
  // Execute the command
  try{
    await exec(`/usr/src/app/send_chars.sh ${data.trim()}`)
  } catch(e){
    console.log(e.message)
  }
});


serialPort.on('data', (data) => {
  const lines = data.toString().split('\r\n');
  for (const line of lines) {
    console.log(`Received line: ${line}`);
  }
})

// Event handler for errors
serialPort.on('error', (error) => {
  console.error(`Serial port error: ${error.message}`);
});


// Event handler for open port
serialPort.on('open', () => {
  console.log(`Serial port ${portPath} opened`);
});