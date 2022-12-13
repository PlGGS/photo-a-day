//basically the twitter timeline view

import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:photoaday/services/auth.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  //switch login with google / apple buttons depending on operating system
  final isAndroid = Device.get().isAndroid;

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
                icon: Transform.translate(
                  offset:
                      isAndroid ? const Offset(0, 0) : const Offset(-2.5, 0),
                  child: Icon(
                    (isAndroid)
                        ? FontAwesomeIcons.google
                        : FontAwesomeIcons.apple,
                    color: Theme.of(context).iconTheme.color,
                    size: (isAndroid) ? 24 : 31,
                  ),
                ),
                text: (isAndroid) ? 'Login with Google' : 'Login with Apple',
                textColor: Theme.of(context).iconTheme.color ??
                    Theme.of(context).primaryColor,
                loginMethod: (isAndroid)
                    ? AuthService().googleLogin
                    : AuthService().appleLogin,
                color: Theme.of(context).primaryIconTheme.color ??
                    Theme.of(context).backgroundColor,
              ),
            ),
            Flexible(
              child: LoginButton(
                icon: Transform.translate(
                  offset:
                      isAndroid ? const Offset(-2.5, 0) : const Offset(0, 0),
                  child: Icon(
                    (isAndroid)
                        ? FontAwesomeIcons.apple
                        : FontAwesomeIcons.google,
                    color: Theme.of(context).iconTheme.color,
                    size: (isAndroid) ? 31 : 24,
                  ),
                ),
                text: (isAndroid) ? 'Login with Apple' : 'Login with Google',
                textColor: Theme.of(context).iconTheme.color ??
                    Theme.of(context).primaryColor,
                loginMethod: (isAndroid)
                    ? AuthService().appleLogin
                    : AuthService().googleLogin,
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
