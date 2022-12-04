import 'package:photoaday/main.dart';
import 'package:photoaday/widgets/pages/home/Home.dart';
import 'package:photoaday/widgets/pages/profile/Profile.dart';
import 'package:photoaday/widgets/pages/project/Project.dart';

//TODO show top and bottom bar above pages in navigator
//possibly do this by creating our own primitive navigator class
//Then use this navigator for additional pages within each major view

var appRoutes = {
  '/profile': (context) => Profile(),
  '/twitter': (context) => const Home(),
  '/project': (context) => const Project(),
};
