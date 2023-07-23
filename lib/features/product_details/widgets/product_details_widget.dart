import 'package:flutter/cupertino.dart';
import 'package:casa/features/home/models/places_model.dart';
import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/custom_network_image.dart';

class ProductDetailsWidget extends StatelessWidget {
  final ProductItem productItem;
  const ProductDetailsWidget({Key? key, required this.productItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
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
                  productItem.category ?? "",
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
                  productItem.description ?? " kfnnrigigiegio",
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
                itemCount: productItem.images?.length ?? 0,
                itemBuilder: (c, index) => Padding(
                  padding:
                      EdgeInsets.only(right: index == 0 ? 24.w : 0, left: 12.w),
                  child: CustomNetworkImage.containerNewWorkImage(
                      image: productItem.image ?? "",
                      width: 100.w,
                      fit: BoxFit.cover,
                      height: 150.h,
                      radius: 8),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
