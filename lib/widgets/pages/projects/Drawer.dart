import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:photoaday/services/models.dart';

class ProjectDrawer extends StatelessWidget {
  final List<Project> projects;
  const ProjectDrawer({
    Key? key,
    required this.projects,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: projects.length,
          itemBuilder: (BuildContext context, int idx) {
            Project project = projects[idx];
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              elevation: 4,
              margin: const EdgeInsets.all(8),
              child: InkWell(
                // onTap: () {
                //   Navigator.of(context).push(
                //     MaterialPageRoute(
                //       builder: (BuildContext context) =>
                //           QuizScreen(quizId: quiz.id),
                //     ),
                //   );
                // },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(
                      project.name,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      project.description,
                      overflow: TextOverflow.fade,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    //TODO pull project image/icon from project type
                    leading: const Icon(FontAwesomeIcons.checkDouble,
                        color: Colors.green),
                  ),
                ),
              ),
            );
          },
        ),
        const NewProjectButton(),
      ],
    ));
  }
}

class NewProjectButton extends StatelessWidget {
  const NewProjectButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      elevation: 4,
      margin: const EdgeInsets.fromLTRB(32, 8, 32, 8),
      child: InkWell(
        // onTap: () {
        //   Navigator.of(context).push(
        //     MaterialPageRoute(
        //       builder: (BuildContext context) =>
        //           QuizScreen(quizId: quiz.id),
        //     ),
        //   );
        // },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            title: Text(
              "New project",
              style: Theme.of(context).textTheme.headline6,
            ),
            leading:
                const Icon(FontAwesomeIcons.circlePlus, color: Colors.blue),
          ),
        ),
      ),
    );
  }
}

class ProjectBadge extends StatelessWidget {
  const ProjectBadge({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(FontAwesomeIcons.checkDouble, color: Colors.green);
  }
}
