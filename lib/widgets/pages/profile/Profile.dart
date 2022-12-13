//basically bumble profile page

import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:photoaday/services/auth.dart';
import 'dart:async';
import 'package:photoaday/widgets/pages/profile/EditDescription.dart';
import 'package:photoaday/widgets/pages/profile/EditEmail.dart';
import 'package:photoaday/widgets/pages/profile/EditImage.dart';
import 'package:photoaday/widgets/pages/profile/EditName.dart';
import 'package:photoaday/widgets/pages/profile/EditPhone.dart';
import 'package:photoaday/widgets/pages/profile/User.dart';
import 'package:photoaday/widgets/pages/profile/UserData.dart';
import 'package:photoaday/widgets/pages/profile/UserImage.dart';

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
        children: [
          Container(
            padding: (Device.get().isAndroid)
                ? const EdgeInsets.fromLTRB(0, 16, 11, 0)
                : const EdgeInsets.fromLTRB(0, 13, 11, 0),
            child: Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: AuthService().logOut,
                icon: const Icon(FontAwesomeIcons.arrowRightFromBracket),
                iconSize: 20,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          Container(
            child: InkWell(
              onTap: () {
                navigateSecondPage(const EditImagePage());
              },
              child: DisplayImage(
                imagePath: user.image,
                onPressed: () {},
              ),
            ),
          ),
          Center(
            child: InkWell(
              onTap: () {
                navigateSecondPage(const EditNameFormPage());
              },
              child: Container(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  user.name,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(64, 105, 225, 1),
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: buildUserInfoDisplay(
                user.name, 'Name', const EditNameFormPage()),
          ),
          Center(
            child: buildUserInfoDisplay(
                user.phone, 'Phone', const EditPhoneFormPage()),
          ),
          Center(
            child: buildUserInfoDisplay(
                user.email, 'Email', const EditEmailFormPage()),
          ),
          Center(
            child: Expanded(
              flex: 4,
              child: buildAbout(user),
            ),
          ),
        ],
      ),
    );
  }

  // Widget builds the display item with the proper formatting to display the user's info
  Widget buildUserInfoDisplay(String getValue, String title, Widget editPage) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 1,
            ),
            Container(
              width: 350,
              height: 40,
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: Colors.grey,
                width: 1,
              ))),
              child: Row(
                children: [
                  Expanded(
                      child: TextButton(
                          onPressed: () {
                            navigateSecondPage(editPage);
                          },
                          child: Text(
                            getValue,
                            style: const TextStyle(fontSize: 16, height: 1.4),
                          ))),
                  const Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.grey,
                    size: 40.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      );

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
