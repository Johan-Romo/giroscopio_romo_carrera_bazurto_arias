import 'package:flutter/material.dart';
import 'view/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // Reemplaza la IP y el puerto por los de tu servidor WebSocket local
  final String serverUrl = 'ws://10.40.12.247:8080';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Control por Giroscopio',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(serverUrl: serverUrl),
    );
  }
}
