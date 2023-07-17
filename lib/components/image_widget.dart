import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


abstract class ImageWidget {

  static Widget network(String url,
      {double? height,
        double? width,
        BoxFit fit = BoxFit.cover,
        BorderRadiusGeometry border = BorderRadius.zero,
        Function()? onReload}) {
    return ClipRRect(
      borderRadius: border,
      child: CachedNetworkImage(
          imageUrl: url,
          height: height,
          width: width,
          errorWidget: (context, url, error) => Center(
              child: Container(
                height: height,
                width: width,
                color: Colors.grey[300],
                child: const Center(
                    child: Text(
                      "404",
                      style: TextStyle(fontSize: 12),
                    )),
              )),
          fit: fit,
          placeholder:(context, url) => const SizedBox(child: CupertinoActivityIndicator.partiallyRevealed()),)
    );
  }

  static Widget assets(String path,
      {double? height,
        double? width,
        BoxFit fit = BoxFit.cover,
        Color? color,
        BorderRadiusGeometry border = BorderRadius.zero}) {
    return ClipRRect(
      borderRadius: border,
      child: Image.asset(
        path,
        height: height,
        width: width,
        color: color,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => Center(
            child: Container(
                height: height,
                width: width,
                color: Colors.grey,
                child: const Center(child: Icon(Icons.replay, color: Colors.green)))),
      ),
    );
  }

  static Widget file(File file,
      {double? height,
        double? width,
        BoxFit fit = BoxFit.cover,
        BorderRadiusGeometry border = BorderRadius.zero}) {
    return ClipRRect(
      borderRadius: border,
      child: Image.file(
        file,
        height: height,
        width: width,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => Center(
            child: Container(
                height: height,
                width: width,
                color: Colors.grey,
                child: const Center(child: Icon(Icons.replay, color: Colors.green)))),
      ),
    );
  }
}


