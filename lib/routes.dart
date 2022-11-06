import 'package:photoaday/main.dart';
import 'package:photoaday/widgets/views/profile/Profile.dart';
import 'package:photoaday/widgets/views/twitter/Timeline.dart';
import 'package:photoaday/widgets/views/tinder/Tinder.dart';
import 'package:photoaday/widgets/views/trending/Trending.dart';
import 'package:photoaday/widgets/views/conversations/Conversations.dart';

//TODO show top and bottom bar above views in navigator
//possibly do this by creating our own primitive navigator class
//Then use this navigator for additional pages within each major view

var appRoutes = {
  '/profile': (context) => Profile(),
  '/twitter': (context) => const Timeline(),
  '/tinder': (context) => const Tinder(),
  '/trending': (context) => const Trending(),
  '/conversations': (context) => const Conversations(),
};
