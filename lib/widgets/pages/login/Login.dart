//basically the twitter timeline view

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photoaday/services/auth.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const FlutterLogo(
              size: 150,
            ),
            Flexible(
              child: LoginButton(
                icon: const Icon(
                  FontAwesomeIcons.user,
                  color: Colors.white,
                ),
                text: 'Continue as Guest',
                loginMethod: AuthService().anonymousLogin,
                color: Colors.deepPurple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final String text;
  final Color color;
  final Icon icon;
  final Function loginMethod;

  const LoginButton({
    Key? key,
    required this.text,
    required this.color,
    required this.icon,
    required this.loginMethod,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      elevation: 4,
      margin: const EdgeInsets.fromLTRB(32, 8, 32, 8),
      color: color,
      child: InkWell(
        onTap: () => loginMethod(),
        child: Container(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            title: Text(
              text,
              style: const TextStyle(color: Colors.white),
            ),
            leading: icon,
          ),
        ),
      ),
    );
  }
}
