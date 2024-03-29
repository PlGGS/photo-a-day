import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:photoaday/services/services.dart';
import 'package:photoaday/widgets/pages/PageCallback.dart';
import 'package:photoaday/widgets/pages/profile/Profile.dart';
import 'package:photoaday/widgets/shared/Shared.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  final PageCallback? onIconButtonTap;

  const Home({
    Key? key,
    this.onIconButtonTap,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final bool recentPhotoFrontFacing = true; //TODO default to back camera?

  late CameraController _cameraController;
  late List<CameraDescription> _cameras;
  bool _isReady = false;

  @override
  void initState() {
    super.initState();
    setupCameras();
  }

  Future<void> setupCameras() async {
    try {
      // initialize cameras
      _cameras = await availableCameras();
      _cameraController = CameraController(
          _cameras[recentPhotoFrontFacing ? 1 : 0], ResolutionPreset.ultraHigh);
      await _cameraController.initialize();

      setState(() {
        _isReady = true;
      });
    } on CameraException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (_isReady) {
      return Scaffold(
        body: Column(
          children: [
            Expanded(
              child: CameraPreview(_cameraController),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: TextButton(
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Theme.of(context).backgroundColor,
                  ),
                ),
                onPressed: () async {
                  // take a picture
                  try {
                    XFile picXFile = await _cameraController.takePicture();
                    await SharedPreferences.getInstance().then(
                      (prefs) {
                        //'${picXFile.path}/${prefs.getString('appName')}/${DateTime.now()}.jpg'

                        GallerySaver.saveImage(
                          picXFile.path,
                          albumName: prefs.getString('appName'),
                        );

                        DioClientService().uploadImage(picXFile.path);

                        prefs.setString('recentPhotoPath', picXFile.path);
                        prefs.setBool(
                            'recentPhotoFrontFacing', recentPhotoFrontFacing);

                        widget.onIconButtonTap!(2);
                      },
                    );
                  } catch (e) {
                    if (kDebugMode) {
                      print(e);
                    }
                  }
                },
              ),
            ),
          ],
        ),
      );
    } else {
      return const Center();
    }
  }
}
