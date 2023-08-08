import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../app/core/utils/styles.dart';
import '../app/core/utils/svg_images.dart';
import 'custom_images.dart';

class FilteredBackIcon extends StatelessWidget {
  const FilteredBackIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(100),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(100)),
          child: customImageIconSVG(
              imageName: SvgImages.arrowRight, color: Styles.WHITE_COLOR),
        ),
      ),
    );
  }
}
