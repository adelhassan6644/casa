import 'package:casa/app/core/utils/extensions.dart';
import 'package:casa/components/custom_app_bar.dart';
import 'package:casa/components/custom_network_image.dart';
import 'package:flutter/material.dart';

class ImageViewer extends StatelessWidget {
  const ImageViewer({
    Key? key,
    required this.image,
    this.isFromInternet = false,
  }) : super(key: key);

  final dynamic image;
  final bool isFromInternet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: isFromInternet
          ? Center(
              child: CustomNetworkImage.containerNewWorkImage(
                  image: image,
                  fit: BoxFit.fitWidth,
                  radius: 0,
                  width: context.width,
                  height: context.width * 1.4),
            )
          : Image.file(
              image,
              fit: BoxFit.fitWidth,
            ),
    );
  }
}
