import 'dart:io';
import 'dart:typed_data';

import 'package:cross_file/cross_file.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'filter_selector.dart';

@immutable
class PhotoFilterCarousel extends StatefulWidget {
  const PhotoFilterCarousel({super.key, this.imageFile});

  // Optional captured image file (from Praktikum 1). If provided, the
  // carousel will use this image instead of the network placeholder.
  final XFile? imageFile;

  @override
  State<PhotoFilterCarousel> createState() => _PhotoFilterCarouselState();
}

class _PhotoFilterCarouselState extends State<PhotoFilterCarousel> {
  final _filters = [
    Colors.white,
    ...List.generate(
      Colors.primaries.length,
      (index) => Colors.primaries[(index * 4) % Colors.primaries.length],
    )
  ];

  final _filterColor = ValueNotifier<Color>(Colors.white);

  void _onFilterChanged(Color value) {
    _filterColor.value = value;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Stack(
        children: [
          Positioned.fill(
            child: _buildPhotoWithFilter(),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: _buildFilterSelector(),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoWithFilter() {
    return ValueListenableBuilder<Color>(
      valueListenable: _filterColor,
      builder: (context, color, child) {
        // If an image file was provided (from Praktikum 1), use it. On Web
        // we must read bytes and use Image.memory; on mobile we can use Image.file.
        if (widget.imageFile != null) {
          final file = widget.imageFile!;
          if (kIsWeb) {
            return FutureBuilder<Uint8List>(
              future: file.readAsBytes(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                  return Image.memory(
                    snapshot.data!,
                    color: color.withOpacity(0.5),
                    colorBlendMode: BlendMode.color,
                    fit: BoxFit.cover,
                  );
                } else if (snapshot.hasError) {
                  return _buildImageError();
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            );
          } else {
            return Image.file(
              File(file.path),
              color: color.withOpacity(0.5),
              colorBlendMode: BlendMode.color,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => _buildImageError(),
            );
          }
        }

        // Default: use the network placeholder image.
        return Image.network(
          // Use a reliable placeholder image. Replace with your own image URL if desired.
          'https://picsum.photos/seed/millennial-dude/1200/2000',
          color: color.withOpacity(0.5),
          colorBlendMode: BlendMode.color,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => _buildImageError(),
        );
      },
    );
  }

  Widget _buildImageError() {
    return Container(
      color: Colors.black,
      alignment: Alignment.center,
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.broken_image, color: Colors.white54, size: 48),
          SizedBox(height: 8),
          Text('Image not available', style: TextStyle(color: Colors.white54)),
        ],
      ),
    );
  }

  Widget _buildFilterSelector() {
    return FilterSelector(
      onFilterChanged: _onFilterChanged,
      filters: _filters,
    );
  }
}
