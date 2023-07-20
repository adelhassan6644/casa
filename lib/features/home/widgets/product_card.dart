import 'package:flutter/material.dart';
import 'package:casa/app/core/utils/dimensions.dart';
import 'package:casa/app/core/utils/extensions.dart';
import 'package:casa/features/favourite/widgets/favourite_button.dart';
import 'package:casa/features/home/models/places_model.dart';
import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_images.dart';
import '../../../components/custom_network_image.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);
  final ProductItem product;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
           onTap: () =>
               CustomNavigator.push(Routes.PRODUCT_DETAILS, arguments: product.id),
          child: Container(
            width: 210.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Styles.WHITE_COLOR,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomNetworkImage.containerNewWorkImage(
                  image: product.image ?? "",
                  height: 100.h,
                  width: context.width,
                  fit: BoxFit.cover,
                  radius: 12.w,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("${product.category}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.semiBold.copyWith(
                              fontSize: 14, color: Styles.PRIMARY_COLOR)),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 6.h),
                        child: Text("${product.name}",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.regular.copyWith(
                              height: 1,
                                fontSize: 14, color: Styles.DETAILS_COLOR)),
                      ),
                      Row(children: [
                        Expanded(
                          child: Text("${100} ريال",
                              maxLines: 1,
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.medium.copyWith(
                                  fontSize: 14, color: Styles.PRIMARY_COLOR)),
                        ),
                        CustomButton(
                          width: 60.w,
                          height: 25.h,
                          text: "حجز",
                        ),
                      ],)
                    ],),
                ),
              ],
            ),
          ),
        ),
        Positioned(top: -10, left: -10, child: FavouriteButton(id: product.id))
      ],
    );
  }
}
