
const robot = require('robotjs');
const express = require('express');
const app = express();
const server = require('http').createServer(app);
const webSocket = require('ws');

const wss = new webSocket.Server({server: server});

    wss.on('connection', function connection(ws) {
        console.log("a New Client is connected");
        ws.send("Welcome to the server");
        ws.on('message', function incoming(message) {  
            var json = JSON.parse(message);     
            switch (json["data"]["type"]) {
                case "mouse":
                    var mouse = robot.getMousePos();
                    console.log("x:"+json["data"]["pointX"]);
                    console.log("y:"+json["data"]["pointY"]);                    
                    robot.moveMouseSmooth(mouse.x + json["data"]['pointX'],mouse.y + json["data"]['pointY'], 1);
                    break;
                case "leftMouse":
                    robot.mouseClick("left");
                    break;
                case "rightMouse":
                    robot.mouseClick("right"); 
                    break;
                case "scrollMouse":
                    robot.scrollMouse(json["data"]['pointX'], json["data"]['pointY']);
                    break;
                case "keyboard":
                    robot.typeString(json["data"]['command']);
                    break;
                default:
                    break;
            }
        });
    });
    
    app.get('/', (req, res) => res.send('Hello World!'));
    
    server.listen(3000, () => {
        console.log('Server listening at port %d', 3000); });