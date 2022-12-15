import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photoaday/widgets/pages/profile/UserData.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';

class EditImagePage extends StatefulWidget {
  const EditImagePage({Key? key}) : super(key: key);

  @override
  _EditImagePageState createState() => _EditImagePageState();
}

class _EditImagePageState extends State<EditImagePage> {
  var user = UserData.myUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(top: 100),
                width: 330,
                child: const Text(
                  "Upload a photo of yourself:",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                )),
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
                    final name = basename(image.path);
                    final imageFile = File('${location.path}/$name');
                    final newImage =
                        await File(image.path).copy(imageFile.path);
                    setState(() => user = user.copy(imagePath: newImage.path));
                  },
                  child: buildImage(user.image, Theme.of(context).focusColor),
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
          ],
        ),
      ),
    );
  }

  // Builds Profile Image
  Widget buildImage(String imagePath, Color color) {
    final image =
        (imagePath.contains('https://') || imagePath.contains('http://'))
            ? NetworkImage(imagePath)
            : FileImage(File(imagePath));

    return CircleAvatar(
      radius: 150,
      backgroundColor: color,
      child: CircleAvatar(
        backgroundImage: image as ImageProvider,
        radius: 145,
      ),
    );
  }
}
