import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class GalleryWidget extends StatelessWidget {
  static const title = 'Images gallery';

  final List<XFile> images;

  const GalleryWidget({
    super.key,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: images.length,
      itemBuilder: (_, index) {
        return SizedBox.square(
          dimension: 200,
          child: Image.file(
            File(images[index].path),
            fit: BoxFit.fill,
          ),
        );
      },
    );
  }
}
