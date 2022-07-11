import 'package:flutter/material.dart';
import 'package:flutter_remote_control/remote_control/controller/api_controller.dart';
import 'package:flutter_remote_control/remote_control/views/home/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ApiController(),
      child: MaterialApp(
        title: 'Flutter Remote Control',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}
