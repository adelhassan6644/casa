import 'package:casa/app/core/utils/extensions.dart';
import 'package:casa/app/core/utils/svg_images.dart';
import 'package:casa/app/localization/localization/language_constant.dart';
import 'package:casa/components/custom_images.dart';
import 'package:casa/components/shimmer/custom_shimmer.dart';
import 'package:casa/features/home/provider/home_provider.dart';
import 'package:casa/navigation/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:casa/app/core/utils/styles.dart';
import 'package:casa/app/core/utils/dimensions.dart';
import 'package:casa/app/core/utils/text_styles.dart';
import 'package:provider/provider.dart';
import '../../../components/marquee_widget.dart';
import '../../../components/tab_widget.dart';
import '../../../navigation/routes.dart';
import '../../maps/provider/map_provider.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
              vertical: Dimensions.PADDING_SIZE_SMALL.h),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        getTranslated("welcome_description", context),
                        style: AppTextStyles.medium.copyWith(
                            fontSize: 18, color: Styles.PRIMARY_COLOR),
                      ),
                      Text(
                        "Mohamed",
                        style: AppTextStyles.semiBold.copyWith(
                            fontSize: 18,
                            color: Styles.PRIMARY_COLOR,
                            height: 1),
                      ),
                    ],
                  ),
                  const Expanded(child: SizedBox()),
                  customContainerSvgIcon(
                      imageName: SvgImages.notifications,
                      radius: 100,
                      height: 45,
                      width: 45,
                      onTap: () => CustomNavigator.push(Routes.NOTIFICATIONS))
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL.h),
                child: InkWell(
                  // onTap: () => CustomBottomSheet.show(
                  //     buttonText: "select_address",
                  //     label: getTranslated("pick_address", context),
                  //     list: Consumer<AddressesProvider>(
                  //       builder: (_,provider,child) {
                  //         return !provider.isLoading
                  //             ?Column(
                  //           children: [
                  //             SizedBox(
                  //               height: 8.h,
                  //             ),
                  //             if (provider.model != null &&
                  //                 provider.model!.data!
                  //                     .isNotEmpty)
                  //               ...List.generate(
                  //                   provider.model!.data!.length,
                  //                       (index) => AddressCard(
                  //                     onTap: ()=>provider.selectAddress(provider.model!.data![index]),
                  //                     addressItem: provider.model!.data![index],
                  //                     isSelect: provider.selectedAddress?.id ==provider.model!.data![index].id ,
                  //                   )),
                  //             if (provider.model == null ||
                  //                 provider.model!.data!
                  //                     .isEmpty)
                  //               EmptyState(
                  //                   txt: getTranslated(
                  //                       "there_is_no_addresses",
                  //                       context)),
                  //           ],
                  //         )
                  //             :Column(
                  //           children: [
                  //             SizedBox(
                  //               height: 8.h,
                  //             ),
                  //             ...List.generate(
                  //                 10,
                  //                     (index) => Container(
                  //                   margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL.h),
                  //                   decoration: BoxDecoration(
                  //                       border: Border(
                  //                           bottom: BorderSide(
                  //                               color: Styles.LIGHT_BORDER_COLOR,
                  //                               width: 1.h))),
                  //                   child: CustomShimmerContainer(
                  //                     width: context.width,
                  //                     height: 80.h,
                  //                     radius: 15,
                  //                   ),
                  //                 ))
                  //           ],
                  //         );
                  //       }
                  //     ),
                  //     onConfirm: () => CustomNavigator.pop()),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customImageIconSVG(
                          imageName: SvgImages.location,
                          height: 20,
                          width: 20,
                          color: Styles.DETAILS_COLOR),
                      SizedBox(
                        width: 8.w,
                      ),
                      Expanded(
                        child: Consumer<MapProvider>(
                            builder: (_, provider, child) {
                          return MarqueeWidget(
                            child: Text(
                                provider.currentLocation?.address ??
                                    "المملكة العربية السعودية",
                                maxLines: 1,
                                style: AppTextStyles.medium.copyWith(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 14,
                                    color: Styles.DETAILS_COLOR)),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Consumer<HomeProvider>(builder: (_, provider, child) {
          return AnimatedCrossFade(
            crossFadeState: CrossFadeState.showFirst,
            firstChild: Container(
              width: context.width,
              height: 35,
              decoration: const BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(width: 1, color: Styles.BORDER_COLOR))),
              alignment: Alignment.bottomCenter,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: provider.isGetCategories
                      ? List.generate(
                          5,
                          (index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Dimensions.PADDING_SIZE_SMALL.w),
                              child: const CustomShimmerContainer(
                                width: 80,
                                height: 35,
                              ),
                            );
                          },
                        )
                      : List.generate(
                          provider.categories?.length ?? 0,
                          (index) {
                            return TabWidget(
                              title: provider.categories?[index].title ?? "",
                              width: 100,
                              isSelected: provider.currentTab ==
                                  provider.categories?[index].id,
                              withBorder: false,
                              onTab: () {
                                if (provider.currentTab !=
                                    provider.categories?[index].id) {
                                  provider.selectTab(index);
                                }
                              },
                            );
                          },
                        ),
                ),
              ),
            ),
            secondChild: const SizedBox(),
            duration: const Duration(milliseconds: 500),
          );
        }),
      ],
    );
  }
}
