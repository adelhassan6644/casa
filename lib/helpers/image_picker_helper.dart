import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../navigation/custom_navigation.dart';

abstract class ImagePickerHelper {
  static showOptionDialog({ ValueChanged<File>? onGet}) {
    showDialog(
      context: CustomNavigator.navigatorState.currentContext!,
      builder: (_) {
        return CupertinoAlertDialog(
          title: const Center(child: Text('Select Image Source')),
          actions: [
            CupertinoDialogAction(child: const Text('Gallery'), onPressed: () => openGallery(onGet: onGet)),
            CupertinoDialogAction(child: const Text('Camera'), onPressed: () => openCamera(onGet: onGet)),
          ],
        );
      },
    );
  }

  static showOptionSheet({ ValueChanged<File>? onGet}) {
    showCupertinoModalPopup(
        context: CustomNavigator.navigatorState.currentContext!,
        builder: (_) {
          return CupertinoActionSheet(
            title:  const Text("Choose your image",
                style:TextStyle(
                  fontSize: 16,
                )),
            actions: [
              CupertinoDialogAction(child: const Text('Gallery'), onPressed: () => openGallery(onGet: onGet)),
              CupertinoDialogAction(child: const Text('Camera'), onPressed: () => openCamera(onGet: onGet)),
            ],

            cancelButton: CupertinoActionSheetAction(
                onPressed: () {
                CustomNavigator.pop();
                },
                child: const Text("Cancel",
                    style: TextStyle(color: Colors.red))),
          );
        });
  }

  static openGallery({ValueChanged<File>? onGet}) async {
    CustomNavigator.pop();
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    onGet!(File(image!.path));
  }

  static openCamera({ValueChanged<File>? onGet}) async {
    CustomNavigator.pop();
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    onGet!(File(image!.path));
  }
}
