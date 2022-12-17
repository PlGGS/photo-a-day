import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:photo_view/photo_view.dart';

class PhotoDisplay extends StatelessWidget {
  const PhotoDisplay({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200.0,
      height: 200.0,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        elevation: 4,
        margin: const EdgeInsets.all(10),
        child: Align(
          alignment: Alignment.topLeft,
          child: SizedBox(
            child: PhotoView(
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.contained,
              backgroundDecoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
              ),
              imageProvider: const CachedNetworkImageProvider(
                'https://blakeboris.com/punchout.jpg',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
