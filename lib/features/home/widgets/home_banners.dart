import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:casa/app/core/utils/dimensions.dart';
import 'package:casa/app/core/utils/extensions.dart';
import 'package:casa/components/custom_button.dart';
import 'package:casa/features/home/provider/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../app/core/utils/images.dart';
import '../../../app/core/utils/styles.dart';
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
                                onTap: () {
                                  // CustomNavigator.push(Routes.PLACE_DETAILS,
                                  //     arguments: provider.bannerModel
                                  //             ?.data?[index].place?.id ??
                                  //         0);
                                },
                                child: Stack(
                                  alignment: Alignment.centerRight,
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
                                          horizontal: Dimensions.PADDING_SIZE_SMALL.w,
                                          vertical: Dimensions.PADDING_SIZE_SMALL.h),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          customImageIcon(imageName: Images.logo,height: 50,width: 75),
                                          Text("العناية بالبشرة",
                                            style:
                                            AppTextStyles.bold.copyWith(
                                              fontSize: 25,
                                              color: Styles.WHITE_COLOR,
                                            ),
                                          ),
                                          Text("عندنا غير",
                                            style:
                                            AppTextStyles.regular.copyWith(
                                              fontSize: 18,
                                              color: Styles.WHITE_COLOR,
                                            ),
                                          ),
                                          Visibility(
                                            visible: index ==
                                                provider.bannerIndex,
                                            child: CustomButton(
                                              width: 100.w,
                                              height: 35.h,
                                              text: "المزيد",
                                              svgIcon:
                                              SvgImages.arrowLeftIcon,
                                              iconColor: Styles.WHITE_COLOR,
                                              onTap: () {
                                                provider.bannerController
                                                    .nextPage();
                                              },
                                            ),
                                          )
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
            height: 210.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Styles.WHITE_COLOR,
            )),
      ),
    );
  }
}
