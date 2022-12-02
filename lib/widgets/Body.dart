import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  Body({
    Key? key,
    required this.height,
    required this.color,
    required this.scaffoldKey,
    required this.currentView,
  }) : super(key: key);

  final double height;
  final Color color;
  final GlobalKey<ScaffoldState> scaffoldKey;
  Widget currentView;

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
            widget.currentView,
            IconButton(
              icon: const Icon(Icons.menu_rounded),
              iconSize: 30,
              padding: const EdgeInsets.fromLTRB(20, 50, 0, 0),
              color: Theme.of(context).primaryColor,
              onPressed: () => widget.scaffoldKey.currentState?.openDrawer(),
            ),
          ],
        ));
  }
}
