import 'package:flutter/material.dart';

import '../app/core/utils/color_resources.dart';
import '../app/core/utils/svg_images.dart';
import '../app/core/utils/text_styles.dart';
import '../features/maps/models/location_model.dart';
import '../main_models/base_model.dart';
import '../navigation/custom_navigation.dart';
import '../navigation/routes.dart';
import 'custom_images.dart';
import 'marquee_widget.dart';

class CustomAddressPicker extends StatelessWidget {
  const CustomAddressPicker(
      {required this.hint, this.location, required this.onPicked, this.decoration, Key? key})
      : super(key: key);

  final String hint;
  final LocationModel? location;
  final ValueChanged onPicked;
  final  Decoration? decoration ;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CustomNavigator.push(Routes.MAP,
            arguments: BaseModel(valueChanged: onPicked, object: location));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        decoration:decoration ,
        child: Row(
          children: [
            Expanded(
              child: MarqueeWidget(
                child: Text(
                  location?.address ?? hint,
                  style: AppTextStyles.regular.copyWith(
                      color: location?.address == null
                          ? Styles.DISABLED
                          : Styles.SECOUND_PRIMARY_COLOR,
                      fontSize: 14,
                      overflow: TextOverflow.ellipsis),
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            customImageIconSVG(imageName: SvgImages.map)
          ],
        ),
      ),
    );
  }
}
