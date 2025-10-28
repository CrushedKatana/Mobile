import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'filter_carousel.dart';
import 'takepicture_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Praktikum Apps')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.camera_alt),
              label: const Text('Camera (Praktikum 1)'),
              onPressed: () async {
                try {
                  // Obtain available cameras at tap time.
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

            const SizedBox(height: 20),

            ElevatedButton.icon(
              icon: const Icon(Icons.photo_library),
              label: const Text('Photo Filter Carousel (Praktikum 2)'),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const PhotoFilterCarousel()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
