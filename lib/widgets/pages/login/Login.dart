//basically the twitter timeline view

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:photoaday/services/auth.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Padding(
              padding: EdgeInsets.all(50),
            ),
            const FlutterLogo(
              size: 150,
            ),
            const Padding(
              padding: EdgeInsets.all(80),
            ),
            Flexible(
              child: LoginButton(
                icon: Icon(
                  FontAwesomeIcons.google,
                  color: Theme.of(context).iconTheme.color,
                ),
                text: 'Login with Google',
                textColor: Theme.of(context).iconTheme.color ??
                    Theme.of(context).primaryColor,
                loginMethod: AuthService().googleLogin,
                color: Theme.of(context).primaryIconTheme.color ??
                    Theme.of(context).backgroundColor,
              ),
            ),
            Flexible(
              child: LoginButton(
                icon: Transform.translate(
                  offset: const Offset(-2.5, 0),
                  child: Icon(
                    FontAwesomeIcons.apple,
                    color: Theme.of(context).iconTheme.color,
                    size: 31,
                  ),
                ),
                text: 'Login with Apple',
                textColor: Theme.of(context).iconTheme.color ??
                    Theme.of(context).primaryColor,
                loginMethod: AuthService().appleLogin,
                color: Theme.of(context).primaryIconTheme.color ??
                    Theme.of(context).backgroundColor,
              ),
            ),
            Flexible(
              child: LoginButton(
                icon: const Icon(
                  FontAwesomeIcons.user,
                  color: Colors.white,
                ),
                text: 'Continue as Guest',
                textColor: Colors.white,
                loginMethod: AuthService().anonymousLogin,
                color: Colors.deepPurple,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color color;
  final Widget icon;
  final Function loginMethod;

  const LoginButton({
    Key? key,
    required this.text,
    required this.textColor,
    required this.color,
    required this.icon,
    required this.loginMethod,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      elevation: 4,
      margin: const EdgeInsets.fromLTRB(20, 8, 20, 8),
      color: color,
      child: InkWell(
        onTap: () => loginMethod(),
        child: Container(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            title: Text(
              text,
              style: TextStyle(color: textColor),
            ),
            leading: icon,
          ),
        ),
      ),
    );
  }
}
