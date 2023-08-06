import 'package:carousel_slider/carousel_slider.dart';
import 'package:casa/app/localization/localization/language_constant.dart';
import 'package:flutter/material.dart';
import 'package:casa/app/core/utils/dimensions.dart';
import 'package:casa/app/core/utils/extensions.dart';
import 'package:casa/components/custom_button.dart';
import 'package:casa/features/home/provider/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../components/custom_network_image.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, provider, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          provider.isGetBanners
              ? const _BannerShimmer()
              : provider.bannerModel != null &&
                      provider.bannerModel?.data != null &&
                      provider.bannerModel!.data!.isNotEmpty
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                          vertical: Dimensions.PADDING_SIZE_SMALL.h),
                      child: Column(
                        children: [
                          CarouselSlider.builder(
                            options: CarouselOptions(
                              viewportFraction: 1,
                              aspectRatio: 0.7,
                              autoPlay: false,
                              height: 210.h,
                              enlargeCenterPage: false,
                              disableCenter: true,
                              pageSnapping: true,
                              onPageChanged: (index, reason) {
                                provider.setBannerIndex(index);
                              },
                            ),
                            disableGesture: true,
                            itemCount: provider.bannerModel?.data?.length ?? 0,
                            itemBuilder: (context, index, _) {
                              return InkWell(
                                focusColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                onTap: () {
                                  if (provider.bannerModel?.data?[index]
                                          .subServiceId !=
                                      null) {
                                    CustomNavigator.push(Routes.PRODUCT_DETAILS,
                                        arguments: provider.bannerModel
                                            ?.data?[index].subServiceId);
                                  }
                                },
                                child: Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    CustomNetworkImage.containerNewWorkImage(
                                        image: provider.bannerModel
                                                ?.data?[index].image ??
                                            "",
                                        width: context.width,
                                        height: 210.h,
                                        fit: BoxFit.cover,
                                        radius: 18),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                Dimensions.PADDING_SIZE_SMALL.w,
                                            vertical: Dimensions
                                                .PADDING_SIZE_SMALL.h),
                                        child: Visibility(
                                          visible:
                                              index == provider.bannerIndex,
                                          child: CustomButton(
                                            width: 115,
                                            height: 35.h,
                                            text:
                                                getTranslated("more", context),
                                            svgIcon: SvgImages.arrowLeft,
                                            iconColor: Styles.WHITE_COLOR,
                                            onTap: () {
                                              provider.bannerController
                                                  .nextPage();
                                            },
                                          ),
                                        )),
                                  ],
                                ),
                              );
                            },
                            carouselController: provider.bannerController,
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: provider.bannerModel!.data!.map((banner) {
                              int index =
                                  provider.bannerModel!.data!.indexOf(banner);
                              return AnimatedContainer(
                                width: index == provider.bannerIndex ? 10 : 7,
                                height: index == provider.bannerIndex ? 10 : 7,
                                duration: const Duration(
                                  milliseconds: 200,
                                ),
                                margin: EdgeInsets.symmetric(horizontal: 2.w),
                                decoration: BoxDecoration(
                                  color: Styles.PRIMARY_COLOR.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(100.w),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),
        ],
      );
    });
  }
}

class _BannerShimmer extends StatelessWidget {
  const _BannerShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
          vertical: Dimensions.PADDING_SIZE_SMALL.h),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        enabled: true,
        child: Container(
            width: context.width,
            height: 210.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Styles.WHITE_COLOR,
            )),
      ),
    );
  }
}
