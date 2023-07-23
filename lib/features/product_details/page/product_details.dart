import 'package:casa/components/shimmer/custom_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:casa/app/core/utils/extensions.dart';
import 'package:casa/components/custom_network_image.dart';
import 'package:casa/features/product_details/provider/product_details_provider.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_button.dart';
import '../../../components/empty_widget.dart';
import '../widgets/product_details_widget.dart';

class ProductDetails extends StatefulWidget {
  final int id;

  const ProductDetails({Key? key, required this.id}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Provider.of<ProductDetailsProvider>(context, listen: false).model = null;
      Provider.of<ProductDetailsProvider>(context, listen: false).geDetails(widget.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Consumer<ProductDetailsProvider>(
            builder: (context, provider, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  provider.isLoading
                      ? CustomShimmerContainer(
                          height: 300.h,
                          width: context.width,
                        )
                      : Visibility(
                    visible: !provider.isLoading && provider.model != null,
                    child: CustomNetworkImage.containerNewWorkImage(
                            image: provider.model?.image ?? "",
                            width: context.width,
                            fit: BoxFit.fitWidth,
                            height: 300.h,
                            radius: 0),
                      ),
                  const CustomAppBar(),
                ],
              ),
              provider.isLoading
                  ? const _ProductDetailsWidgetShimmer()
                  : provider.model != null
                      ? ProductDetailsWidget(
                          productItem: provider.model!,
                        )
                      : const EmptyState(),
              Visibility(
                visible: !provider.isLoading && provider.model != null,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: Dimensions.PADDING_SIZE_DEFAULT.h,
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                  child: CustomButton(
                    text: "حجز موعد",
                    svgIcon: SvgImages.arrowLeft,
                    iconColor: Styles.WHITE_COLOR,
                    onTap: () {},
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class _ProductDetailsWidgetShimmer extends StatelessWidget {
  const _ProductDetailsWidgetShimmer({Key? key}) : super(key: key);

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
                const CustomShimmerContainer(
                  width: 150,
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.h),
                  child: const CustomShimmerContainer(
                    width: 150,
                    height: 30,
                  ),
                ),
                ...List.generate(
                  5,
                  (index) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                    child: CustomShimmerContainer(
                      width: context.width,
                      height: 15,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 184.h,
            child: Center(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (c, index) => Padding(
                  padding:
                      EdgeInsets.only(right: index == 0 ? 24.w : 0, left: 12.w),
                  child: CustomShimmerContainer(
                    width: 100.w,
                    height: 150.h,
                    radius: 8,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
