import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:photo_view/photo_view.dart';

import 'package:photoaday/services/services.dart';
import 'package:photoaday/widgets/pages/home/Home.dart';
import 'package:photoaday/routes.dart';
import 'package:photoaday/widgets/Body.dart';
import 'package:photoaday/widgets/BottomBar.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:photoaday/widgets/pages/project/PhotoDisplay.dart';
import 'package:photoaday/widgets/pages/login/Login.dart';
import 'package:photoaday/widgets/pages/profile/Profile.dart';
import 'package:photoaday/widgets/pages/project/Project.dart';
import 'package:photoaday/widgets/pages/projects/Drawer.dart';
import 'package:photoaday/widgets/shared/Error.dart';
import 'package:system_theme/system_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({Key? key}) : super(key: key);

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  PageController pageController = PageController(initialPage: 1);

  void updateCurrentPage(int page) {
    setState(() {
      pageController.animateToPage(page,
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeInOutSine);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            scrollDirection: Axis.vertical,
            children: const [
              PhotoDisplay(),
            ],
          ),
        ],
      ),
    );
  }
}

enum ProjectTypes {
  daily,
  weekly,
  single,
}
