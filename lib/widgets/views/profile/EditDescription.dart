import 'package:flutter/material.dart';
import 'package:photoaday/widgets/views/profile/UserData.dart';

// This class handles the Page to edit the About Me Section of the User Profile.
class EditDescriptionFormPage extends StatefulWidget {
  @override
  _EditDescriptionFormPageState createState() =>
      _EditDescriptionFormPageState();
}

class _EditDescriptionFormPageState extends State<EditDescriptionFormPage> {
  final _formKey = GlobalKey<FormState>();
  final descriptionController = TextEditingController();
  var user = UserData.myUser;

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  void updateUserValue(String description) {
    user.aboutMeDescription = description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(top: 100),
                    width: 350,
                    child: Text(
                      "Describe yourself",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    )),
                Padding(
                    padding: EdgeInsets.all(80),
                    child: SizedBox(
                        height: 150,
                        width: 500,
                        child: TextFormField(
                          // Handles Form Validation
                          minLines: 10,
                          maxLines: 15,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length > 200) {
                              return 'Please describe yourself but keep it under 200 characters.';
                            }
                            return null;
                          },
                          controller: descriptionController,
                          textAlignVertical: TextAlignVertical.top,
                          decoration: const InputDecoration(
                              isDense: true,
                              alignLabelWithHint: true,
                              contentPadding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                              hintMaxLines: 3,
                              hintText:
                                  'Write a little bit about yourself. Do you like chatting? Are you a smoker? Do you bring pets with you? Etc.'),
                        ))),
                Padding(
                  padding: EdgeInsets.only(top: 0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: 350,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate()) {
                            updateUserValue(descriptionController.text);
                            Navigator.pop(context);
                          }
                        },
                        child: const Text(
                          'Update',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
