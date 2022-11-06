//basically the tinder swiping view

import 'dart:math';
import 'package:flutter/material.dart';

class Tinder extends StatelessWidget {
  const Tinder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (_, index) {
        return Container(
          color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
          height: 500,
          width: 500,
          child: const Text('tinder'),
        );
      },
    );
  }
}
