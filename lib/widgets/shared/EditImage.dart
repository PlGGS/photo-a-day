import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photoaday/widgets/shared/CircleImage.dart';

class EditImage extends StatelessWidget {
  final double radius;
  final double borderRatio;
  final Color borderColor;
  final String imagePath;
  final VoidCallback onPressed;

  const EditImage({
    Key? key,
    required this.radius,
    required this.borderRatio,
    required this.borderColor,
    required this.imagePath,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).focusColor;

    return CircleImage(
      radius: radius,
      borderRatio: borderRatio,
      borderColor: borderColor,
      imagePath: imagePath,
      onPressed: onPressed,
      child: Positioned(
        right: 4,
        bottom: 10,
        child: buildEditIcon(color),
      ),
    );
  }

  // Builds Edit Icon on Profile Picture
  Widget buildEditIcon(Color color) => buildCircle(
        all: 8,
        color: color,
        child: Icon(
          Icons.edit,
          color: color,
          size: 15,
        ),
      );

  // Builds/Makes Circle
  Widget buildCircle({
    required Color color,
    required Widget child,
    required double all,
  }) =>
      CircleAvatar(
        radius: 20,
        backgroundColor: color,
        child: ClipOval(
          child: Container(
            padding: EdgeInsets.all(all),
            color: Colors.white,
            child: child,
          ),
        ),
      );
}
