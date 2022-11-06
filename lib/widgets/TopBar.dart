import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  const TopBar({Key? key, required this.height, required this.color})
      : super(key: key);

  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      // color: Color.fromARGB(255, 255, 150, 191),
      height: height,
      alignment: Alignment.center,
      // child: Stack(
      //   children: [
      //     IconButton(
      //       icon: const Icon(Icons.data_usage_sharp),
      //       iconSize: 30,
      //       color: Colors.white,
      //       onPressed: () {},
      //       // highlightColor: const Color.fromARGB(255, 255, 150, 191),
      //     ),
      //   ],
      // )
    );
  }
}
