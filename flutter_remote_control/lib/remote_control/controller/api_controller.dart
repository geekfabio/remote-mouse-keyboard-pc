import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ApiController extends ChangeNotifier {
  Offset? screenSize;

  //TODO implement sharedPreferences to save URI on device
  //Add your own IP address here
  WebSocketChannel channel =
      WebSocketChannel.connect(Uri.parse('ws://192.168.1.103:3000'));

  var message = {
    'data': {'type': "string", 'command': 'string'}
  };
  var mouseCommand = {
    'data': {
      "pointX": 0.0,
      'pointY': 0.0,
      'type': "",
    }
  };
  Future sendMouseCommand(Offset location, {String type = "mouse"}) async {
    Future.delayed(const Duration(milliseconds: 50));
    mouseCommand = {
      'data': {
        "pointX": location.dx,
        'pointY': location.dy,
        'type': type,
      }
    };
    try {
      channel.sink.add(jsonEncode(mouseCommand));
    } on Exception catch (e) {
      print(e);
    }
  }

  Future sendCommand({required String command, required String type}) async {
    Future.delayed(const Duration(milliseconds: 200));
    message = {
      'data': {'type': type, 'command': command}
    };
    channel.sink.add(jsonEncode(message));
  }

  Future closeChannel() async {
    await Future.delayed(const Duration(seconds: 3));
    channel.sink.close();
  }

  //TODO * connect a local websocket and send message

}
