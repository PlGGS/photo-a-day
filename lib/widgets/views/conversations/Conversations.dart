//conversations view will contain the profiles of those who liked you
//above your conversations list

import 'dart:math';
import 'package:flutter/material.dart';

class Conversations extends StatelessWidget {
  const Conversations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (_, index) {
        return Container(
          color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
          height: 500,
          width: 500,
          child: const Text('conversations'),
        );
      },
    );
  }
}
