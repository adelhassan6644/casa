import 'package:flutter/cupertino.dart';
import 'package:casa/app/core/utils/extensions.dart';
import 'package:casa/components/shimmer/custom_shimmer.dart';
import 'package:casa/features/home/models/places_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_images.dart';
import '../../../components/custom_network_image.dart';

class ProductDetailsWidget extends StatelessWidget {
  final ProductItem placeItem;
  const ProductDetailsWidget({Key? key, required this.placeItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
              vertical: Dimensions.PADDING_SIZE_SMALL.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                placeItem.category ?? "",
                style: AppTextStyles.bold.copyWith(
                    fontSize: 18,
                    overflow: TextOverflow.ellipsis,
                    color: Styles.PRIMARY_COLOR),
                maxLines: 1,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 6.h),
                child: Text(
                  "${100} ريال",
                  style: AppTextStyles.medium.copyWith(
                      fontSize: 16,
                      overflow: TextOverflow.ellipsis,
                      color: Styles.HEADER),
                  maxLines: 1,
                ),
              ),
              Text(
                placeItem.description ?? " kfnnrigigiegio",
                style: AppTextStyles.regular
                    .copyWith(fontSize: 16, color: Styles.DETAILS_COLOR),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 184.h,
          child: Center(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: placeItem.images?.length ?? 0,
              itemBuilder: (c, index) => Padding(
                padding:
                    EdgeInsets.only(right: index == 0 ? 24.w : 0, left: 16.w),
                child: CustomNetworkImage.containerNewWorkImage(
                    image: placeItem.images?[index] ?? "",
                    width: 100.w,
                    fit: BoxFit.fitWidth,
                    height: 150.h,
                    radius: 0),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class PlaceDetailsWidgetShimmer extends StatelessWidget {
  const PlaceDetailsWidgetShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
          vertical: Dimensions.PADDING_SIZE_SMALL.h),
      decoration: const BoxDecoration(
          color: Styles.WHITE_COLOR,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35), topRight: Radius.circular(35))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomShimmerContainer(
            width: 100,
            height: 15,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomShimmerContainer(
                  width: 100,
                  height: 15,
                ),
                Expanded(
                  child: SizedBox(),
                ),
                CustomShimmerContainer(
                  width: 100,
                  height: 35,
                  radius: 100,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                customImageIconSVG(
                    imageName: SvgImages.location,
                    height: 18,
                    width: 18,
                    color: const Color(0xFF656565)),
                SizedBox(
                  width: 8.w,
                ),
                const CustomShimmerContainer(
                  width: 200,
                  height: 15,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                customImageIconSVG(
                    imageName: SvgImages.phoneIcon,
                    height: 16,
                    width: 18,
                    color: const Color(0xFF656565)),
                SizedBox(
                  width: 8.w,
                ),
                const CustomShimmerContainer(
                  width: 200,
                  height: 15,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomShimmerContainer(
                  width: 100,
                  height: 15,
                ),
                SizedBox(
                  height: 4.w,
                ),
                ...List.generate(
                  3,
                  (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: CustomShimmerContainer(
                      width: context.width,
                      height: 15,
                    ),
                  ),
                )
              ],
            ),
          ),
          const CustomShimmerContainer(
            width: 100,
            height: 35,
            radius: 100,
          ),
          SizedBox(
            height: 24.h,
          )
        ],
      ),
    );
  }
}
