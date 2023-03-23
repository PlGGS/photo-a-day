import 'dart:io';

import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  final double radius;
  final double borderRatio;
  final Color borderColor;
  final String imagePath;
  final VoidCallback onPressed;
  final Widget child;

  const CircleImage({
    Key? key,
    required this.radius,
    required this.borderRatio,
    required this.borderColor,
    required this.imagePath,
    required this.onPressed,
    this.child = const SizedBox(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          buildCircleImage(borderColor),
          child,
        ],
      ),
    );
  }

  // Builds Profile Image
  Widget buildCircleImage(Color color) {
    final image = imagePath.contains('https://')
        ? NetworkImage(imagePath)
        : FileImage(File(imagePath));

    return CircleAvatar(
      radius: radius,
      backgroundColor: color,
      child: Stack(
        children: [
          CircleAvatar(
            backgroundImage: image as ImageProvider,
            radius: radius * borderRatio,
          ),
        ],
      ),
    );
  }
}
