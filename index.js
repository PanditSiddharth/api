const express = require('express');
const path = require('path');
const app = express();
const port = 3000;

app.get('/', (req, res) => {
    res.send("Hello");
  });

// Serve the install.sh file at the specified URL
app.get('/iocompiler/termux', (req, res) => {
  res.sendFile(path.join(__dirname, 'install.sh'));
});

app.listen(port, () => {
  console.log(`Server is running at http://localhost:${port}`);
});
