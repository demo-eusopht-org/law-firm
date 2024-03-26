import 'dart:io';

import 'package:flutter/material.dart';

class RoundFileImageView extends StatelessWidget {
  final String filePath;
  final double size;
  final bool showBadge;
  const RoundFileImageView({
    super.key,
    required this.filePath,
    required this.size,
    this.showBadge = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: size,
          height: size,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Image.file(
            File(filePath),
            width: size,
            height: size,
            fit: BoxFit.fitWidth,
          ),
        ),
        if (showBadge) _buildBadge(),
      ],
    );
  }

  Positioned _buildBadge() {
    return Positioned(
      bottom: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: const BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.edit,
          size: 25,
          color: Colors.white,
        ),
      ),
    );
  }
}
