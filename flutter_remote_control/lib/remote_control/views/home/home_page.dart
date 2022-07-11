import 'package:flutter/material.dart';
import 'package:flutter_remote_control/remote_control/controller/api_controller.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final txtcontroller = TextEditingController();
  Offset _startTouch = const Offset(0, 0);
  Offset _endTouch = const Offset(0, 0);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final provider = Provider.of<ApiController>(context, listen: true);
    provider.screenSize = Offset(
        MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
    void changeTextController(String value) {
      txtcontroller.text = value;
      provider.sendCommand(command: value, type: "keyboard");
      txtcontroller.text = "";
    }

    void _onPanStart(DragStartDetails start) {
      Offset pos = (context.findRenderObject() as RenderBox)
          .globalToLocal(start.globalPosition);
      _startTouch = pos;
    }

    void _onPanUpdate(DragUpdateDetails update) {
      Offset pos = (context.findRenderObject() as RenderBox)
          .globalToLocal(update.globalPosition);
      _endTouch = pos;
    }

    void _onPanEnd(DragEndDetails end) {
      Offset localOffest = (_startTouch * 0.8 - _endTouch * 0.8) / 2;    
      provider.sendMouseCommand(localOffest);
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Remote Control'),
        ),
        body: SafeArea(
            child: Column(
          children: <Widget>[
            Flexible(
              flex: 5,
              child: Stack(children: [
                //TouchPad
                GestureDetector(
                  onPanStart: _onPanStart,
                  onPanUpdate: _onPanUpdate,
                  onPanEnd: _onPanEnd,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.all(8),
                    height: size.height / 1.2,
                    width: size.width,
                    color: Colors.blue[100],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: [
                      const Padding(padding: EdgeInsets.all(4)),
                      GestureDetector(
                        onTap: () => provider.sendCommand(
                            command: "leftMouse", type: "leftMouse"),
                        child: Container(
                          height: 50,
                          width: size.width / 2.1,
                          color: const Color.fromARGB(255, 25, 190, 212),
                        ),
                      ),
                      //Line
                      Container(
                        height: 50,
                        width: 2,
                        color: const Color.fromARGB(25, 91, 25, 212),
                      ),
                      GestureDetector(
                        onTap: () => provider.sendCommand(
                            command: "rightMouse", type: "rightMouse"),
                        child: Container(
                          height: 50,
                          width: size.width / 2.1,
                          color: const Color.fromARGB(255, 25, 190, 212),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
            Flexible(
              flex: 1,
              child: Center(
                child: TextField(
                  controller: txtcontroller,
                  onChanged: (text) => changeTextController(text),
                ),
              ),
            ),
          ],
        )));
  }
}
