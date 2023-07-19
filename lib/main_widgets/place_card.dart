import 'package:flutter/material.dart';
import 'package:casa/app/core/utils/dimensions.dart';
import 'package:casa/app/core/utils/extensions.dart';
import 'package:casa/features/favourite/widgets/favourite_button.dart';
import 'package:casa/features/home/models/places_model.dart';
import '../app/core/utils/styles.dart';
import '../app/core/utils/svg_images.dart';
import '../app/core/utils/text_styles.dart';
import '../components/custom_images.dart';
import '../components/custom_network_image.dart';
import '../navigation/custom_navigation.dart';
import '../navigation/routes.dart';

class PlaceCard extends StatelessWidget {
  const PlaceCard({
    Key? key,
    required this.place,
  }) : super(key: key);
  final PlaceItem place;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () =>
              CustomNavigator.push(Routes.PLACE_DETAILS, arguments: place.id),
          child: Container(
            width: 210.w,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Styles.GREY_BORDER,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("${place.category}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.light.copyWith(
                        fontSize: 14, color: Styles.DETAILS_COLOR)),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.h),
                  child: Text("${place.name}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.medium.copyWith(
                          fontSize: 14,
                          color: place.nameColor?.toColor ??
                              Styles.PENDING)),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    customImageIconSVG(
                        imageName: SvgImages.location,
                        height: 20,
                        width: 20,
                        color: Styles.TITLE),
                    SizedBox(
                      width: 4.w,
                    ),
                    Expanded(
                      child: Text(
                        place.address ?? "",
                        style: AppTextStyles.medium.copyWith(
                            fontSize: 14,
                            overflow: TextOverflow.ellipsis,
                            color: Styles.TITLE),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 14.h,
                ),
                CustomNetworkImage.containerNewWorkImage(
                  image: place.image ?? "",
                  height: 120.h,
                  width: context.width,
                  fit: BoxFit.cover,
                  edges: true,
                  radius: 8.w,
                ),
              ],
            ),
          ),
        ),
        Positioned(top: -10, left: -10, child: FavouriteButton(id: place.id))
      ],
    );
  }
}
