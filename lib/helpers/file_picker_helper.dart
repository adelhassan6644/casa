import 'dart:io';
import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';

abstract class FilePickerHelper {
  static Future pickFile({
    String title = "Pick a file",
    FileType? type,
    List<String>? allowedExtensions,
    ValueChanged<File>? onSelected,
    ValueChanged<List<File>>? onSelectedMulti,
    bool multiImages = false,
    Function()? onCancel,
  }) async {
    var result = await FilePicker.platform.pickFiles(
      type: type ?? FileType.any,
      allowMultiple: multiImages,
      dialogTitle: title,
    );
    if (result != null) {
      List<File> files = [];

      for (var element in result.files) {
        files.add(File(element.path!));
      }
      if (onSelectedMulti != null) onSelectedMulti(files);
      if (onSelected != null) onSelected(files.first);
    } else {
      onCancel?.call();
      return null;
    }
  }

  static getFileSize(File file, int decimals) async {
    int bytes = await file.length();
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return  "${(bytes / pow(1024, i)).toStringAsFixed(decimals)}"+' '+"${suffixes[i]}";

  }

  static String getName(String fullName) {
    final parts = fullName.split('/');
    return parts.skip(parts.length - 1).take(1).join('.');
  }
}
