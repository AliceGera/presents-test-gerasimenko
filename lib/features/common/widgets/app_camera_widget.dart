import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/res/resources.dart';
import 'package:image_picker/image_picker.dart';

class AppCameraWidget extends StatefulWidget {
  AppCameraWidget({
    super.key,
    required this.savePhoto,
    this.photoHoliday,
  });

  final Uint8List? photoHoliday;
  void Function(Uint8List photo) savePhoto;

  @override
  _AppCameraWidgetState createState() => _AppCameraWidgetState();
}

class _AppCameraWidgetState extends State<AppCameraWidget> {
  final picker = ImagePicker();
  Uint8List? photo;

  @override
  void initState() {
    photo = widget.photoHoliday;
  }

  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        final image = File(pickedFile.path);
        photo = image.readAsBytesSync();
        if(photo!=null) {
          widget.savePhoto.call(photo!);
        }
      }
    });
  }

  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        final image = File(pickedFile.path);
        photo = image.readAsBytesSync();
        if(photo!=null) {
          widget.savePhoto.call(photo!);
        }
      }
    });
  }

  Future showOptions() async {
    await showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: const Text('Photo Gallery'),
            onPressed: () {
              Navigator.of(context).pop();
              getImageFromGallery();
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Camera'),
            onPressed: () {
              Navigator.of(context).pop();
              getImageFromCamera();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: showOptions,
        child: SizedBox(
          height: 90,
          width: 90,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: DecoratedBox(
              decoration: const BoxDecoration(
                color: AppColors.photoColorGray,
              ),
              child: Center(
                child: photo == null
                    ? InkWell(
                        onTap: showOptions,
                        child: SvgPicture.asset(
                          SvgIcons.photoCamera,
                        ),
                      )
                    : Image.memory(
                        photo!,
                        fit: BoxFit.cover,
                        height: 90,
                        width: 90,
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
