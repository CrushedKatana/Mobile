import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'takepicture_screen.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tugas Praktikum')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Tugas: Ambil foto menggunakan Kamera (Praktikum 1) lalu terapkan filter (Praktikum 2).',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.camera_alt),
              label: const Text('Mulai Tugas - Ambil Foto & Terapkan Filter'),
              onPressed: () async {
                try {
                  final cameras = await availableCameras();
                  if (cameras.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('No cameras available')),
                    );
                    return;
                  }
                  final firstCamera = cameras.first;
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => TakePictureScreen(camera: firstCamera),
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error initializing camera: $e')),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
