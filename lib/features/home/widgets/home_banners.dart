import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:casa/app/core/utils/dimensions.dart';
import 'package:casa/app/core/utils/extensions.dart';
import 'package:casa/components/custom_button.dart';
import 'package:casa/features/home/provider/home_provider.dart';
import 'package:casa/navigation/custom_navigation.dart';
import 'package:casa/navigation/routes.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/custom_images.dart';
import '../../../components/custom_network_image.dart';
import '../../../components/empty_widget.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, provider, child) {
      return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
            vertical: Dimensions.PADDING_SIZE_SMALL.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            provider.isGetBanners
                ? const _BannerShimmer()
                : provider.bannerModel != null &&
                        provider.bannerModel?.data != null &&
                        provider.bannerModel!.data!.isNotEmpty
                    ? Column(
                        children: [
                          CarouselSlider.builder(
                            options: CarouselOptions(
                              viewportFraction: 1,
                              autoPlay: false,
                              height: 245.h,
                              enlargeCenterPage: false,
                              disableCenter: true,
                              pageSnapping: true,
                              onPageChanged: (index, reason) {
                                provider.setPlacesIndex(index);
                              },
                            ),
                            disableGesture: true,
                            itemCount: provider.bannerModel?.data?.length ?? 0,
                            itemBuilder: (context, index, _) {
                              return InkWell(
                                onTap: () {
                                  CustomNavigator.push(Routes.PLACE_DETAILS,
                                      arguments: provider.bannerModel
                                              ?.data?[index].place?.id ??
                                          0);
                                },
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    CustomNetworkImage.containerNewWorkImage(
                                        image: provider.bannerModel
                                                ?.data?[index].image ??
                                            "",
                                        width: context.width,
                                        height: 245.h,
                                        fit: BoxFit.cover,
                                        radius: 20),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 14.w, vertical: 12.h),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            provider.bannerModel?.data?[index]
                                                    .place?.name ??
                                                "",
                                            style:
                                                AppTextStyles.medium.copyWith(
                                              fontSize: 18,
                                              color: Styles.DISABLED,
                                            ),
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              customImageIconSVG(
                                                imageName: SvgImages.location,
                                                height: 20,
                                                width: 20,
                                                color: Styles.DISABLED,
                                              ),
                                              SizedBox(
                                                width: 4.w,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  provider
                                                          .bannerModel
                                                          ?.data?[index]
                                                          .place
                                                          ?.address ??
                                                      "",
                                                  style: AppTextStyles.medium
                                                      .copyWith(
                                                          fontSize: 18,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          color: Styles
                                                              .DISABLED),
                                                  maxLines: 1,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 8.w,
                                              ),
                                              Visibility(
                                                visible: index ==
                                                    provider.bannerIndex,
                                                child: CustomButton(
                                                  width: 110.w,
                                                  height: 35.h,
                                                  text: "المزيد",
                                                  svgIcon:
                                                      SvgImages.arrowRightIcon,
                                                  onTap: () {
                                                    provider.bannerController
                                                        .nextPage();
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
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
                                width: index == provider.bannerIndex ? 25 : 8,
                                height: 8,
                                duration: const Duration(
                                  milliseconds: 200,
                                ),
                                margin: EdgeInsets.symmetric(horizontal: 2.w),
                                decoration: BoxDecoration(
                                    color: index == provider.bannerIndex
                                        ? Styles.SECOUND_PRIMARY_COLOR
                                        : Styles.WHITE_COLOR,
                                    borderRadius: BorderRadius.circular(100.w),
                                    border: Border.all(
                                        color: Styles
                                            .SECOUND_PRIMARY_COLOR,
                                        width: 1)),
                              );
                            }).toList(),
                          ),
                        ],
                      )
                    : const EmptyState(
                        emptyHeight: 200,
                        imgHeight: 110,
                      ),
          ],
        ),
      );
    });
  }
}

class _BannerShimmer extends StatelessWidget {
  const _BannerShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        enabled: true,
        child: Container(
            width: context.width,
            height: 245.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Styles.WHITE_COLOR,
            )),
      ),
    );
  }
}
