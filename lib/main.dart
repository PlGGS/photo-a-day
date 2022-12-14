import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:photoaday/services/services.dart';
import 'package:photoaday/widgets/pages/home/Home.dart';
import 'package:flutter/material.dart';
import 'package:photoaday/routes.dart';
import 'package:photoaday/widgets/Body.dart';
import 'package:photoaday/widgets/BottomBar.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:photoaday/widgets/pages/login/Login.dart';
import 'package:photoaday/widgets/pages/project/Project.dart';
import 'package:photoaday/widgets/pages/projects/Drawer.dart';
import 'package:system_theme/system_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Device.get().isAndroid) await SystemTheme.accentColor.load();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => ThemeModeNotifier(),
      ),
    ],
    child: const PhotoADay(),
  ));
}

class PhotoADay extends StatefulWidget {
  const PhotoADay({Key? key}) : super(key: key);

  @override
  State<PhotoADay> createState() => _PhotoADayState();
}

class _PhotoADayState extends State<PhotoADay> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    //Set the navigation bar black to match the BottomBar
    //All because setting the status bar to black icons on white background doesn't work without an AppBar
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    FlutterStatusbarcolor.setStatusBarColor(Colors.black);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);

    return MaterialApp(
      title: 'Photo A Day',
      theme: ThemeData(
        /* light theme settings */
        brightness: Brightness.light,
        primaryColor: Colors.black,
        backgroundColor: Colors.white,
        focusColor: const Color.fromRGBO(64, 105, 225, 1),
        scaffoldBackgroundColor: Colors.white,
        canvasColor: Colors.white,
        primaryIconTheme: const IconThemeData(color: Colors.white),
        iconTheme: IconThemeData(color: Colors.grey.shade900),
        secondaryHeaderColor: SystemTheme.accentColor.accent,
      ),
      darkTheme: ThemeData(
        /* dark theme settings */
        brightness: Brightness.dark,
        primaryColor: Colors.white,
        backgroundColor: Colors.black,
        focusColor: const Color.fromRGBO(64, 105, 225, 1),
        scaffoldBackgroundColor: Colors.black,
        canvasColor: Colors.black,
        primaryIconTheme: IconThemeData(color: Colors.grey.shade900),
        iconTheme: IconThemeData(color: Colors.grey.shade100),
        secondaryHeaderColor: SystemTheme.accentColor.accent,
      ),
      themeMode: Provider.of<ThemeModeNotifier>(context).themeMode,
      // themeMode: ThemeMode.system,
      /* ThemeMode.system to follow system theme, 
         ThemeMode.light for light theme, 
         ThemeMode.dark for dark theme
      */
      debugShowCheckedModeBanner: false,
      home: MyApp(),
      routes: appRoutes,
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        print("Inactive");
        break;
      case AppLifecycleState.paused:
        print("Paused");
        //TODO handle disabling camera?
        break;
      case AppLifecycleState.resumed:
        print("Resumed");
        //TODO handle enabling camera?
        break;
      case AppLifecycleState.detached:
        print("Detached");
        break;
    }
  }
}

class ThemeModeNotifier with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeModeNotifier() {
    _loadThemeMode();
  }

  Future<void> _loadThemeMode() async {
    await SharedPreferences.getInstance().then((prefs) {
      int themeMode = prefs.getInt('themeMode') ?? 2;

      switch (themeMode) {
        case 0:
          _themeMode = ThemeMode.light;
          break;
        case 1:
          _themeMode = ThemeMode.dark;
          break;
        case 2:
          _themeMode = ThemeMode.system;
          break;
      }
    });

    notifyListeners();
  }

  Future<void> _saveThemeMode() async {
    await SharedPreferences.getInstance().then((prefs) {
      switch (_themeMode) {
        case ThemeMode.light:
          prefs.setInt('themeMode', 0);
          break;
        case ThemeMode.dark:
          prefs.setInt('themeMode', 1);
          break;
        case ThemeMode.system:
          prefs.setInt('themeMode', 2);
          break;
      }
    });
  }

  ThemeMode get themeMode => _themeMode;

  set themeMode(ThemeMode themeMode) {
    if (themeMode == _themeMode) return;

    _themeMode = themeMode;
    notifyListeners();
    _saveThemeMode();
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
  /// The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside [build].
  final Future<FirebaseApp> _firebaseInit = Firebase.initializeApp();

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  //TODO add logic to check whether or not the user has set up their profile
  //take them to their profile if it's definitely not complete yet
  Widget currentPage = const Home();
  PageController pageController = PageController(initialPage: 1);

  void updateCurrentPage(int page) {
    setState(() {
      // if (currentPage != page) currentPage = page;
      pageController.animateToPage(page,
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeInOutSine);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _firebaseInit,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            key: scaffoldKey,
            // Apparenly this is how you make a hidden appbar
            // TODO use this to set status bar color
            // appBar: AppBar(
            //   backgroundColor: Colors.transparent,
            //   elevation: 0,
            //   toolbarHeight: 0,
            // ),
            drawer: ProjectDrawer(
              projects: [
                Project(
                  id: 'bnui2b242hu3vb434m3v2y42',
                  name: 'Test Daily Project',
                  description: 'Take a photo everyday!',
                  type: ProjectTypes.daily,
                  hasBlurb: true,
                  usesTimedNotifications: true,
                  usesRandomNotifications: true,
                  timedNotifications: [DateTime.now()],
                  startRandomNotifications: [DateTime.now()],
                  endRandomNotifications: [DateTime.now()],
                ),
                Project(
                  id: 'bnui2b242hu3vb434m3v2y42',
                  name: 'Test Daily Project',
                  description: 'Take a photo everyday!',
                  type: ProjectTypes.daily,
                  hasBlurb: true,
                  usesTimedNotifications: true,
                  usesRandomNotifications: true,
                  timedNotifications: [DateTime.now()],
                  startRandomNotifications: [DateTime.now()],
                  endRandomNotifications: [DateTime.now()],
                ),
                Project(
                  id: 'bnui2b242hu3vb434m3v2y42',
                  name: 'Test Daily Project',
                  description: 'Take a photo everyday!',
                  type: ProjectTypes.daily,
                  hasBlurb: true,
                  usesTimedNotifications: true,
                  usesRandomNotifications: true,
                  timedNotifications: [DateTime.now()],
                  startRandomNotifications: [DateTime.now()],
                  endRandomNotifications: [DateTime.now()],
                ),
              ],
            ),
            body: Builder(builder: (context) {
              final bodyHeight = MediaQuery.of(context).size.height;
              final bodyWidth = MediaQuery.of(context).size.width;

              double bottomBarHeight = (Device.get().isAndroid) ? 60 : 80;
              const Color bottomBarColor = Colors.black;

              return StreamBuilder(
                stream: AuthService().userStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('Error'),
                    );
                  } else if (snapshot.hasData) {
                    return SizedBox(
                      height: bodyHeight,
                      width: bodyWidth,
                      child: Column(
                        children: [
                          Body(
                            scaffoldKey: scaffoldKey,
                            height: bodyHeight - bottomBarHeight,
                            color: Theme.of(context).canvasColor,
                            currentPage: currentPage,
                            pageController: pageController,
                          ),
                          BottomBar(
                            height: bottomBarHeight,
                            color: bottomBarColor,
                            currentPage: currentPage,
                            onIconButtonTap: updateCurrentPage,
                          ),
                        ],
                      ),
                    );
                  } else {
                    return LoginPage();
                  }
                },
              );
            }),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return const Center(
          child: Text('Loading'),
        );
      },
    );
  }
}
