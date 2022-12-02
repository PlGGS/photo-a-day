import 'package:photoaday/widgets/views/conversations/Conversations.dart';
import 'package:photoaday/widgets/views/home/Home.dart';
import 'package:photoaday/widgets/views/profile/Profile.dart';
import 'package:photoaday/widgets/views/project/Project.dart';
import 'package:flutter/material.dart';

//Callback function to set the current view
//Views are what I'm refering to as widgets that fill the Body section of MyApp in main.dart
typedef ViewCallback = void Function(Widget view);

class BottomBar extends StatefulWidget {
  final ViewCallback onIconButtonTap;
  BottomBar({
    Key? key,
    required this.height,
    required this.color,
    required currentView,
    required this.onIconButtonTap,
  }) : super(key: key);

  final double height;
  final Color color;
  late Widget currentView;

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final double iconSize = 30;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: widget.color,
            height: widget.height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.person_outline),
                  iconSize: iconSize + 3,
                  color: Colors.white,
                  onPressed: () => widget.onIconButtonTap(Profile()),
                  // highlightColor: const Color.fromARGB(255, 255, 150, 191),
                ),
                IconButton(
                  icon: const Icon(Icons.camera_alt_outlined),
                  iconSize: iconSize + 2,
                  color: Colors.white,
                  onPressed: () => widget.onIconButtonTap(const Home()),
                  // highlightColor: const Color.fromARGB(255, 255, 150, 191),
                ),
                IconButton(
                  icon: const Icon(Icons.photo_library_outlined),
                  iconSize: iconSize,
                  color: Colors.white,
                  onPressed: () => widget.onIconButtonTap(const Project()),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
