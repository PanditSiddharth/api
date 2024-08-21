const express = require('express');
const path = require('path');
const app = express();

// Serve the install.sh file at the specified URL
app.get('/iocompiler/termux.sh', (req, res) => {
  res.sendFile(path.join(__dirname, 'install.sh'));
});

module.exports = app;