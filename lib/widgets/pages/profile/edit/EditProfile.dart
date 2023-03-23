import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:photoaday/services/auth.dart';
import 'package:photoaday/services/models.dart';
import 'dart:async';
import 'package:photoaday/widgets/pages/profile/edit/EditDescription.dart';
import 'package:photoaday/widgets/pages/profile/edit/EditEmail.dart';
import 'package:photoaday/widgets/pages/profile/edit/EditImage.dart';
import 'package:photoaday/widgets/pages/profile/edit/EditName.dart';
import 'package:photoaday/widgets/pages/profile/edit/EditPhone.dart';
import 'package:photoaday/widgets/pages/profile/FeatureItem.dart';
import 'package:photoaday/widgets/pages/profile/User.dart';
import 'package:photoaday/widgets/pages/profile/UserData.dart';
import 'package:photoaday/widgets/shared/CircleImage.dart';

// This class handles the Page to display the user's info on the "Edit Profile" Screen
class EditProfile extends StatefulWidget {
  final User user;

  const EditProfile({
    super.key,
    required this.user,
  });

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.user.image,
      child: Scaffold(
        body: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 80, 0, 20),
              child: SizedBox(
                width: 330,
                child: GestureDetector(
                  onTap: () async {
                    final image = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);

                    if (image == null) return;

                    final location = await getApplicationDocumentsDirectory();
                    final name = path.basename(image.path);
                    final imageFile = File('${location.path}/$name');
                    final newImage =
                        await File(image.path).copy(imageFile.path);
                    setState(
                      () => widget.user.image =
                          widget.user.copy(imagePath: newImage.path) as String,
                    );
                  },
                  child: buildImage(
                      widget.user.image, Theme.of(context).focusColor),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 330,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      'Update',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: buildUserInfoDisplay(
                  widget.user.name, 'Name', const EditNameFormPage()),
            ),
            Center(
              child: buildUserInfoDisplay(
                  widget.user.phone, 'Phone', const EditPhoneFormPage()),
            ),
            Center(
              child: buildUserInfoDisplay(
                  widget.user.email, 'Email', const EditEmailFormPage()),
            ),
            Center(
              child: Expanded(
                flex: 4,
                child: buildAbout(widget.user),
              ),
            ),
          ],
        ),
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

  // Builds Profile Image
  Widget buildImage(String imagePath, Color color) {
    final image =
        (imagePath.contains('https://') || imagePath.contains('http://'))
            ? NetworkImage(imagePath)
            : FileImage(File(imagePath));

    return CircleAvatar(
      radius: 120,
      backgroundColor: color,
      child: CircleAvatar(
        backgroundImage: image as ImageProvider,
        radius: 115,
      ),
    );
  }

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
