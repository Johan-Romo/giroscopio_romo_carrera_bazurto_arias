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
        backgroundColor: const Color(0xFFEFD9B4),
        appBar: AppBar(
          backgroundColor: const Color(0xFF4D6160),
          title: const Text('Control por Giroscopio', style: TextStyle(color: Colors.white)),
          centerTitle: true,
          elevation: 2,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                color: const Color(0xFFA39081),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(color: Color(0xFF292522), width: 1.5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: const [
                      Text(
                        'Instrucciones:',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '• Gira el dispositivo sobre el eje X para abrir el navegador.',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      Text(
                        '• Gira el dispositivo sobre el eje Y para abrir Word.',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      Text(
                        '• Gira el dispositivo sobre el eje Z para abrir el reproductor de música.',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Consumer<GyroscopeController>(
                  builder: (context, controller, child) {
                    final data = controller.currentData;
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Card(
                            color: const Color(0xFFA39081),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(color: Color(0xFF292522), width: 1.5),
                            ),

                          ),
                          Card(
                            color: const Color(0xFFD6A692),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: const BorderSide(color: Color(0xFF292522), width: 2),
                            ),
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Giroscopio',
                                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                      color: const Color(0xFF292522),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  _buildDataText('X: ${data.x.toStringAsFixed(2)}'),
                                  _buildDataText('Y: ${data.y.toStringAsFixed(2)}'),
                                  _buildDataText('Z: ${data.z.toStringAsFixed(2)}'),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          if (controller.currentCommand.isNotEmpty)
                            Card(
                              color: const Color(0xFFA39081),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: const BorderSide(color: Color(0xFF292522), width: 1.5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Text(
                                  controller.currentCommand,
                                  style: const TextStyle(fontSize: 18, color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFA39081),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFF292522), width: 1.5),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}