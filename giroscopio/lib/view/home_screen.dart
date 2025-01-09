import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/gyroscope_controller.dart';

class HomeScreen extends StatelessWidget {
  final String serverUrl;

  const HomeScreen({Key? key, required this.serverUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GyroscopeController(serverUrl),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Control por Giroscopio'),
        ),
        body: Consumer<GyroscopeController>(
          builder: (context, controller, child) {
            final data = controller.currentData;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Giroscopio',

                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'X: ${data.x.toStringAsFixed(2)}',

                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    'Y: ${data.y.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    'Z: ${data.z.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'Gira tu dispositivo para enviar comandos.',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
