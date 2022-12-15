import 'package:photoaday/main.dart';
import 'package:photoaday/widgets/pages/home/Home.dart';
import 'package:photoaday/widgets/pages/profile/Profile.dart';
import 'package:photoaday/widgets/pages/project/Project.dart';
import 'package:photoaday/widgets/pages/settings/Settings.dart';

var appRoutes = {
  '/profile': (context) => Profile(),
  '/twitter': (context) => const Home(),
  '/project': (context) => const ProjectPage(),
  '/settings': (context) => const Settings(),
};
