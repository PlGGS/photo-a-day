import 'package:photoaday/widgets/views/conversations/Conversations.dart';
import 'package:photoaday/widgets/views/profile/Profile.dart';
import 'package:photoaday/widgets/views/tinder/Tinder.dart';
import 'package:photoaday/widgets/views/trending/Trending.dart';
import 'package:photoaday/widgets/views/twitter/Timeline.dart';
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
                  icon: const Icon(Icons.person),
                  iconSize: iconSize + 3,
                  color: Colors.white,
                  onPressed: () => widget.onIconButtonTap(Profile()),
                  // highlightColor: const Color.fromARGB(255, 255, 150, 191),
                ),
                IconButton(
                  icon: const Icon(Icons.home_rounded),
                  iconSize: iconSize + 2,
                  color: Colors.white,
                  onPressed: () => widget.onIconButtonTap(const Timeline()),
                  // highlightColor: const Color.fromARGB(255, 255, 150, 191),
                ),
                IconButton(
                  icon: const Icon(Icons.people_alt),
                  iconSize: iconSize,
                  color: Colors.white,
                  onPressed: () => widget.onIconButtonTap(const Tinder()),
                ),
                IconButton(
                  icon: const Icon(Icons.star),
                  iconSize: iconSize - 1,
                  color: Colors.white,
                  onPressed: () => widget.onIconButtonTap(const Trending()),
                ),
                IconButton(
                  icon: const Icon(Icons.message),
                  iconSize: iconSize - 4,
                  color: Colors.white,
                  onPressed: () =>
                      widget.onIconButtonTap(const Conversations()),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
