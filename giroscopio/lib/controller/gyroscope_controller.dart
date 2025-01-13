import 'package:flutter/material.dart';
import 'dart:async';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../model/gyroscope_data.dart';

class GyroscopeController with ChangeNotifier {
  late WebSocketChannel channel;
  GyroscopeData currentData = GyroscopeData(0, 0, 0);
  String currentCommand = '';

  GyroscopeController(String serverUrl) {
    channel = IOWebSocketChannel.connect(Uri.parse(serverUrl));

    gyroscopeEvents.listen((GyroscopeEvent event) {
      currentData = GyroscopeData(event.x, event.y, event.z);
      notifyListeners();
      checkAndSendCommand(currentData);
    });

    channel.stream.listen(
          (message) => print("Mensaje recibido del servidor: $message"),
      onDone: () => print("Conexión WebSocket cerrada"),
      onError: (error) => print("Error en WebSocket: $error"),
    );
  }

  void checkAndSendCommand(GyroscopeData data) {
    const double threshold = 3.0;

    if (data.x.abs() > threshold && data.x.abs() > data.y.abs() && data.x.abs() > data.z.abs()) {
      _setCommand('Abriendo navegador', 'open_web');
    } else if (data.y.abs() > threshold && data.y.abs() > data.x.abs() && data.y.abs() > data.z.abs()) {
      _setCommand('Abriendo Word', 'open_word');
    } else if (data.z.abs() > threshold && data.z.abs() > data.x.abs() && data.z.abs() > data.y.abs()) {
      _setCommand('Abriendo reproductor de música', 'open_player');
    }
  }

  void _setCommand(String commandMessage, String command) {
    if (currentCommand != commandMessage) {
      currentCommand = commandMessage;
      notifyListeners();
      sendCommand(command);
    }
  }

  void sendCommand(String command) {
    print("Enviando comando: $command");
    channel.sink.add(command);
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}