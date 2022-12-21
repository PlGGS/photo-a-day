import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PhotoDisplay extends StatefulWidget {
  Color backgroundColor;

  PhotoDisplay({
    Key? key,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  State<PhotoDisplay> createState() => _PhotoDisplayState();
}

class _PhotoDisplayState extends State<PhotoDisplay> {
  late SharedPreferences prefs;
  String recentPhotoPath = '';
  bool recentPhotoFrontFacing = false;

  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      recentPhotoPath = prefs.getString('recentPhotoPath') ?? '';
      recentPhotoFrontFacing = prefs.getBool('recentPhotoFrontFacing') ?? false;
    });

    if (kDebugMode) {
      print('PHOTO PATH: ${recentPhotoPath}');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (recentPhotoPath != '') {
      return Transform.scale(
        scaleX: (recentPhotoFrontFacing) ? -1 : 1,
        child: SizedBox(
          width: 200.0,
          height: 200.0,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            elevation: 4,
            margin: const EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                child: PhotoView(
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.contained,
                  backgroundDecoration: BoxDecoration(
                    color: widget.backgroundColor,
                  ),
                  imageProvider: FileImage(File(recentPhotoPath)),
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return SizedBox(
        width: 200.0,
        height: 200.0,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          elevation: 4,
          margin: const EdgeInsets.all(10),
        ),
      );
    }
  }
}
