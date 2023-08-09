import 'package:casa/app/core/utils/text_styles.dart';
import 'package:casa/app/localization/localization/language_constant.dart';
import 'package:casa/components/shimmer/custom_shimmer.dart';
import 'package:casa/features/product_details/repo/product_details_repo.dart';
import 'package:casa/navigation/custom_navigation.dart';
import 'package:casa/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:casa/app/core/utils/extensions.dart';
import 'package:casa/components/custom_network_image.dart';
import 'package:casa/features/product_details/provider/product_details_provider.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;

import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_button.dart';
import '../../../components/empty_widget.dart';
import '../../../data/config/di.dart';
import '../../payment/model/payment_body_model.dart';
import '../widgets/product_details_widget.dart';

class ProductDetails extends StatelessWidget {
  final int id;

  const ProductDetails({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (_) => ProductDetailsProvider(repo: sl<ProductDetailsRepo>())
          ..getDetails(id),
        child: SafeArea(
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
                            visible:
                                !provider.isLoading && provider.model != null,
                            child: CustomNetworkImage.containerNewWorkImage(
                                image: provider.model?.image ?? "",
                                width: context.width,
                                fit: BoxFit.fitWidth,
                                height: 300.h,
                                radius: 0),
                          ),
                    CustomAppBar(
                      actionChild: Visibility(
                        visible: !provider.isLoading,
                        child: ClipRRect(
                          clipBehavior: Clip.antiAlias,
                          borderRadius: BorderRadius.circular(100),
                          child: BackdropFilter(
                            filter:
                                ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12.w, vertical: 8.h),
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Styles.WHITE_COLOR),
                                    color: Colors.black.withOpacity(0.06),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Text(
                                  provider.model?.status == 1
                                      ? getTranslated(
                                          "available_for_reservation", context)
                                      : getTranslated(
                                          "unavailable_for_reservation",
                                          context),
                                  style: AppTextStyles.regular.copyWith(
                                      color: Styles.PRIMARY_COLOR,
                                      fontSize: 12),
                                )),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                provider.isLoading
                    ? const _ProductDetailsWidgetShimmer()
                    : provider.model != null
                        ? ProductDetailsWidget(item: provider.model!)
                        : const EmptyState(),
                Visibility(
                  visible: !provider.isLoading && provider.model != null,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: Dimensions.PADDING_SIZE_SMALL.h,
                        horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                    child: CustomButton(
                      text: getTranslated("book_an_appointment", context),
                      svgIcon: SvgImages.arrowLeft,
                      iconColor: Styles.WHITE_COLOR,
                      onTap: () => CustomNavigator.push(Routes.PRODUCT_SCHEDULE,
                          arguments: PaymentBodyModel(model: provider.model)),
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
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
