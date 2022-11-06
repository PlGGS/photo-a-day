import 'package:photoaday/widgets/views/twitter/Timeline.dart';
import 'package:flutter/material.dart';
import 'package:photoaday/routes.dart';
import 'package:photoaday/widgets/TopBar.dart';
import 'package:photoaday/widgets/Body.dart';
import 'package:photoaday/widgets/BottomBar.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';

void main() {
  runApp(const photoaday());
}

class photoaday extends StatelessWidget {
  const photoaday({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Set status bar foreground and background colors
    FlutterStatusbarcolor.setStatusBarColor(Colors.black);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);

    return MaterialApp(
      home: MyApp(),
      routes: appRoutes,
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  //TODO add logic to check whether or not the user has set up their profile
  //take them to their profile if it's definitely not complete yet
  Widget currentView = const Timeline();

  void updateCurrentView(Widget view) {
    setState(() {
      if (currentView != view) currentView = view;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const Drawer(
        child: Text('photoaday'),
      ),
      body: Builder(builder: (context) {
        final bodyHeight = MediaQuery.of(context).size.height;
        final bodyWidth = MediaQuery.of(context).size.width;

        const double topBarHeight = 30;
        const double bottomBarHeight = 60;

        const Color topBarColor = Color.fromARGB(255, 0, 150, 191);
        const Color bodyColor = Color.fromARGB(255, 255, 150, 191);
        const Color bottomBarColor = Colors.black;

        return Container(
          height: bodyHeight,
          width: bodyWidth,
          child: Column(
            children: [
              Body(
                scaffoldKey: scaffoldKey,
                height: bodyHeight - bottomBarHeight,
                color: topBarColor,
                currentView: currentView,
              ),
              BottomBar(
                height: bottomBarHeight,
                color: bottomBarColor,
                currentView: currentView,
                onIconButtonTap: updateCurrentView,
              ),
            ],
          ),
        );
      }),
    );
  }
}

class Swipes extends StatelessWidget {
  const Swipes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: null,
    );
  }
}

class Likes extends StatelessWidget {
  const Likes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: null,
    );
  }
}
