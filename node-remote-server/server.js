//create a server using robot.js to reveive key and mouse and execute from url


const robot = require('robotjs');
const server = require('http').createServer(app);
const io = require('socket.io')(server);

const PORT = process.env.PORT || 3000;

server.listen(PORT, () => {
  console.log('Server listening at port %d', PORT);
});

app.get('/', (req, res) => {});

app.use(express.static('public'));

io.on('connection', (socket) => {
  console.log('a user connected');
  socket.on('keyboard', (data) => {
    console.log('keyboard: ', data);
  //  robot.keyTap(data.key);
  });
  socket.on('mouse', (data) => {
    console.log('mouse: ', data);
   // robot.moveMouse(data.x, data.y);
  });

  socket.on('message', (data) => {
    console.log('message: ', data);
  });
});