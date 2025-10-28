import 'dart:io';
import 'dart:typed_data';

import 'package:cross_file/cross_file.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final XFile imageFile;

  const DisplayPictureScreen({super.key, required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture - 2341720205')),
      // On web, Image.file is not supported. Read bytes and use Image.memory.
      body: kIsWeb
          ? FutureBuilder<Uint8List>(
              future: imageFile.readAsBytes(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                  return Image.memory(snapshot.data!);
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error loading image: ${snapshot.error}'));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            )
          : Image.file(File(imageFile.path)),
    );
  }
}
