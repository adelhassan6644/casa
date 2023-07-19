import 'dart:developer';
import 'package:permission_handler/permission_handler.dart';

abstract class PermissionHandler {
  static Future<bool> _checkPermissionIsGranted(Permission permission) async =>
      permission.isGranted;
  static Future<bool> _checkPermission(Permission permission) async {
    if (!(await _checkPermissionIsGranted(permission))) {
      if (await permission.isPermanentlyDenied) {
        log("message1");
        return false;
      } else {
        PermissionStatus value = await permission.request();
        log(value.name);
        return await _checkPermissionIsGranted(permission);
      }
    } else {
      log("message3");
      return true;
    }
  }

  static Future<bool> checkCameraPermission() async =>
      await _checkPermission(Permission.camera);
  static Future<bool> checkBluetoothPermission() async =>
      await _checkPermission(Permission.bluetoothConnect);
  static Future<bool> checkContactsPermission() async =>
      await _checkPermission(Permission.contacts);
  static Future<bool> checkGalleryPermission() async =>
      await _checkPermission(Permission.photos);
  static Future<bool> checkFilePermission() async =>
      await _checkPermission(Permission.storage);
}
