import 'package:flutter/material.dart';
import 'package:photoaday/widgets/pages/settings/Settings.dart';

// This class handles the Page to display the user's settings
class Section extends StatefulWidget {
  final String title;
  final List<Setting> settings;

  // Constructor
  const Section({
    Key? key,
    required this.title,
    required this.settings,
  }) : super(key: key);

  @override
  _SectionState createState() => _SectionState();
}

class _SectionState extends State<Section> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 38, 0, 12),
          child: Text(
            widget.title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.settings.length,
          itemBuilder: (BuildContext context, int idx) {
            Setting setting = widget.settings[idx];
            return Card(
              // shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(25)),
              elevation: 0,
              // margin: const EdgeInsets.all(8),
              child: InkWell(
                onTap: () => setting.onSettingTap,
                splashColor:
                    (setting.option == null) ? Colors.grey : Colors.transparent,
                highlightColor:
                    (setting.option == null) ? Colors.grey : Colors.transparent,
                child: ListTile(
                  tileColor: Theme.of(context).backgroundColor,
                  title: Text(
                    setting.name,
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  subtitle: Text(
                    setting.description,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  trailing: setting.option,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
