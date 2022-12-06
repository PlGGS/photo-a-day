//basically the twitter timeline view

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ProjectPage extends StatelessWidget {
  const ProjectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const RecentPhoto();
  }
}

class RecentPhoto extends StatelessWidget {
  const RecentPhoto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhotoView(
      imageProvider: const NetworkImage('https://blakeboris.com/cubs.jpg'),
      minScale: PhotoViewComputedScale.contained,
      maxScale: PhotoViewComputedScale.contained,
      backgroundDecoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
      ),
    );
  }
}

enum ProjectTypes {
  daily,
  weekly,
  single,
}
