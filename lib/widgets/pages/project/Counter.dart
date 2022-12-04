//basically the twitter timeline view

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class Counter extends StatelessWidget {
  const Counter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: Future.value(2),
      builder: (context, snapshot) {
        var count = snapshot.data;
        return Text('$count');
      },
    );
  }
}
