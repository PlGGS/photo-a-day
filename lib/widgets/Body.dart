import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:photoaday/widgets/pages/PageCallback.dart';
import 'package:photoaday/widgets/pages/profile/Profile.dart';
import 'package:photoaday/widgets/pages/home/Home.dart';
import 'package:photoaday/widgets/pages/project/Project.dart';

class Body extends StatefulWidget {
  final double height;
  final Color color;
  final GlobalKey<ScaffoldState> scaffoldKey;
  Widget currentPage;
  PageController pageController;
  final PageCallback onIconButtonTap;

  Body({
    Key? key,
    required this.height,
    required this.color,
    required this.scaffoldKey,
    required this.currentPage,
    required this.pageController,
    required this.onIconButtonTap,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.color,
      height: widget.height,
      alignment: Alignment.topLeft,
      child: Stack(
        children: [
          PageView(
            controller: widget.pageController,
            children: [
              Profile(),
              Home(onIconButtonTap: widget.onIconButtonTap),
              const ProjectPage(),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.menu_rounded),
            iconSize: 30,
            padding: (Device.get().isAndroid)
                ? const EdgeInsets.fromLTRB(20, 50, 0, 0)
                : const EdgeInsets.fromLTRB(20, 70, 0, 0),
            color: Theme.of(context).primaryColor,
            onPressed: () => widget.scaffoldKey.currentState?.openDrawer(),
          ),
        ],
      ),
    );
  }
}
