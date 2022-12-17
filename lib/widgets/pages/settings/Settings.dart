import 'package:flutter/material.dart';
import 'package:photoaday/widgets/pages/settings/Section.dart';

class Setting {
  final String name;
  final String description;
  final void Function() onSettingTap;
  final Widget? option;

  const Setting({
    required this.name,
    this.description = '',
    this.onSettingTap = emptyOnSettingTap,
    this.option,
  });

  static void emptyOnSettingTap() {}
}

// This class handles the Page to display the user's settings
class Settings extends StatefulWidget {
  const Settings({
    Key? key,
  }) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool testToggle = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).backgroundColor,
        title: const Text(
          'Settings',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Section(
            title: 'Account',
            settings: <Setting>[
              Setting(
                name: 'Test Toggle',
                description: 'This setting toggles the switch',
                //TODO add cupertinoswitch for ios
                option: Switch(
                  value: testToggle,
                  activeColor: Colors.red,
                  onChanged: (bool value) {
                    // This is called when the user toggles the switch.
                    setState(() {
                      testToggle = value;
                    });
                  },
                ),
              ),
              const Setting(
                name: 'Test Empty',
                description: 'This option would take the user to a submenu',
              ),
              const Setting(
                name: 'Test Empty 2',
                //TODO add cupertinoswitch for ios
              ),
            ],
          ),
        ],
      ),
    );
  }
}
