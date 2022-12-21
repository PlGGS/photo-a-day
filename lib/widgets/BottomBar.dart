import 'package:photoaday/widgets/pages/PageCallback.dart';
import 'package:photoaday/widgets/pages/home/Home.dart';
import 'package:photoaday/widgets/pages/profile/Profile.dart';
import 'package:photoaday/widgets/pages/project/Project.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  final double height;
  final Color color;
  late Widget currentPage;
  final PageCallback onIconButtonTap;

  BottomBar({
    Key? key,
    required this.height,
    required this.color,
    required currentPage,
    required this.onIconButtonTap,
  }) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  PageController pageController = PageController(initialPage: 1);
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
                  onPressed: () => widget.onIconButtonTap(0),
                  // onPressed: () => Navigator.pushNamed(context, '/profile'),
                  // highlightColor: const Color.fromARGB(255, 255, 150, 191),
                ),
                IconButton(
                  icon: const Icon(Icons.camera_alt_outlined),
                  iconSize: iconSize + 2,
                  color: Colors.white,
                  onPressed: () => widget.onIconButtonTap(1),
                  // onPressed: () => Navigator.pushNamed(context, '/'),
                  // highlightColor: const Color.fromARGB(255, 255, 150, 191),
                ),
                IconButton(
                  icon: const Icon(Icons.photo_library_outlined),
                  iconSize: iconSize,
                  color: Colors.white,
                  onPressed: () => widget.onIconButtonTap(2),
                  // onPressed: () => Navigator.pushNamed(context, '/project'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
