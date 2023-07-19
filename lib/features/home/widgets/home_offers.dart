import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:casa/app/core/utils/dimensions.dart';
import 'package:casa/app/core/utils/extensions.dart';
import 'package:casa/app/core/utils/images.dart';
import 'package:casa/features/home/provider/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/custom_network_image.dart';
import '../../../components/empty_widget.dart';

class HomeOffers extends StatelessWidget {
  const HomeOffers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
          ),
          child: Row(
            children: [
              Text(
                "العروض ",
                style: AppTextStyles.semiBold
                    .copyWith(fontSize: 24, color: Styles.HEADER),
              ),
              Image.asset(
                Images.megaPhone,
                height: 26,
                width: 26,
              )
            ],
          ),
        ),
        SizedBox(
          height: 24.h,
        ),
        Consumer<HomeProvider>(builder: (context, provider, child) {
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                vertical: Dimensions.PADDING_SIZE_SMALL.h),
            child: provider.isGetOffers
                ? const _OfferShimmer()
                : provider.offersModel != null &&
                        provider.offersModel?.data != null &&
                        provider.offersModel!.data!.isNotEmpty
                    ? Column(
                        children: [
                          CarouselSlider.builder(
                            options: CarouselOptions(
                              viewportFraction: 1,
                              autoPlay: true,
                              height: 205.h,
                              onPageChanged: (index, reason) {
                                provider.setOffersIndex(index);
                              },
                            ),
                            disableGesture: true,
                            itemCount: provider.offersModel?.data?.length ?? 0,
                            itemBuilder: (context, index, _) {
                              return CustomNetworkImage.containerNewWorkImage(
                                  image: provider
                                          .offersModel?.data?[index].image ??
                                      "",
                                  width: context.width,
                                  height: 205.h,
                                  fit: BoxFit.cover,
                                  radius: 20);
                            },
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: provider.offersModel!.data!.map((offer) {
                              int index =
                                  provider.offersModel!.data!.indexOf(offer);
                              return AnimatedContainer(
                                width: index == provider.offersIndex ? 25 : 8,
                                height: 8,
                                duration: const Duration(
                                  milliseconds: 200,
                                ),
                                margin: EdgeInsets.symmetric(horizontal: 2.w),
                                decoration: BoxDecoration(
                                    color: index == provider.offersIndex
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
          );
        }),
      ],
    );
  }
}

class _OfferShimmer extends StatelessWidget {
  const _OfferShimmer({Key? key}) : super(key: key);

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
            height: 205.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Styles.WHITE_COLOR,
            )),
      ),
    );
  }
}
