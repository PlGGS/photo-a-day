import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:photoaday/services/auth.dart';
import 'package:photoaday/services/models.dart';
import 'package:photoaday/services/services.dart';
import 'dart:async';
import 'package:photoaday/widgets/pages/profile/edit/EditDescription.dart';
import 'package:photoaday/widgets/pages/profile/edit/EditName.dart';
import 'package:photoaday/widgets/pages/profile/edit/EditProfile.dart';
import 'package:photoaday/widgets/pages/profile/FeatureItem.dart';
import 'package:photoaday/widgets/pages/profile/User.dart';
import 'package:photoaday/widgets/pages/profile/UserData.dart';
import 'package:photoaday/widgets/pages/profile/UserImage.dart';
import 'package:photoaday/widgets/pages/settings/Settings.dart';
import 'package:photoaday/widgets/shared/Shared.dart';

// This class handles the Page to display the user's info on the "Edit Profile" Screen
class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final user = UserData.myUser;

    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
            padding: (Device.get().isAndroid)
                ? const EdgeInsets.fromLTRB(0, 16, 11, 0)
                : const EdgeInsets.fromLTRB(0, 13, 11, 0),
            child: Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () => Navigator.pushNamed(context, '/settings'),
                icon: const Icon(FontAwesomeIcons.gear),
                iconSize: 20,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              navigateSecondPage(
                EditProfile(
                  user: user,
                ),
              );
            },
            child: DisplayImage(
              imagePath: user.image,
              onPressed: () {},
            ),
          ),
          Center(
            child: InkWell(
              onTap: () {
                navigateSecondPage(const EditNameFormPage());
              },
              child: Container(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  user.name,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ),
          buildFeaturesSection(),
        ],
      ),
    );
  }

  Widget buildFeaturesSection() => FutureBuilder<List<Feature>>(
        future: FirestoreService().getFeatures(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingScreen();
          } else if (snapshot.hasError) {
            return ErrorMessage(message: snapshot.error.toString());
          } else if (snapshot.hasData) {
            var features = snapshot.data!;
            return buildHorizontalScrollingSection('Features', features);
          } else {
            return const Text('No topics found in Firestore. Check database');
          }
        },
      );

  Widget buildHorizontalScrollingSection(String title, items) {
    double listHeight = 150;

    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 20, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          SizedBox(
            height: listHeight,
            child: ListView.builder(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                var item = items!.elementAt(index);

                return Center(
                  child: FeatureItem(
                    height: listHeight,
                    feature: Feature(
                      title: item.title,
                      subtitle: 'Go to the polls',
                      imageUri: 'https://blakeboris.com/pond.jpg',
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Widget builds the About Me Section
  Widget buildAbout(User user) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tell Us About Yourself',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 1),
            Container(
              width: 350,
              height: 200,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        navigateSecondPage(EditDescriptionFormPage());
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            user.aboutMeDescription,
                            style: const TextStyle(
                              fontSize: 16,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.grey,
                    size: 40.0,
                  )
                ],
              ),
            ),
          ],
        ),
      );

  // Refrshes the Page after updating user info.
  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  // Handles navigation and prompts refresh.
  void navigateSecondPage(Widget editForm) {
    Route route = MaterialPageRoute(builder: (context) => editForm);
    Navigator.push(context, route).then(onGoBack);
  }
}
