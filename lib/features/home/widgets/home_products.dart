import 'package:casa/app/core/utils/extensions.dart';
import 'package:casa/features/home/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/styles.dart';
import '../../../components/animated_widget.dart';
import '../../../components/empty_widget.dart';
import '../../../components/grid_list_animator.dart';
import '../../../components/shimmer/custom_shimmer.dart';
import '../../../components/tab_widget.dart';
import 'product_card.dart';

class HomeProducts extends StatelessWidget {
  const HomeProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Consumer<HomeProvider>(builder: (_, provider, child) {
        //   return AnimatedCrossFade(
        //     crossFadeState: CrossFadeState.showFirst,
        //     firstChild: Container(
        //       width: context.width,
        //       height: 35,
        //       decoration: const BoxDecoration(
        //           border: Border(
        //               bottom:
        //               BorderSide(width: 1, color: Styles.BORDER_COLOR))),
        //       alignment: Alignment.bottomCenter,
        //       child: SingleChildScrollView(
        //         scrollDirection: Axis.horizontal,
        //         physics: const BouncingScrollPhysics(),
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.start,
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: provider.isGetCategories
        //               ? List.generate(
        //             5,
        //                 (index) {
        //               return Padding(
        //                 padding: EdgeInsets.symmetric(
        //                     horizontal: Dimensions.PADDING_SIZE_SMALL.w),
        //                 child: const CustomShimmerContainer(
        //                   width: 80,
        //                   height: 35,
        //                 ),
        //               );
        //             },
        //           )
        //               : List.generate(
        //             provider.categories?.length ?? 0,
        //                 (index) {
        //               return TabWidget(
        //                 title: provider.categories?[index].title ?? "",
        //                 width: 100,
        //                 isSelected: provider.currentTab ==
        //                     provider.categories?[index].id,
        //                 withBorder: false,
        //                 onTab: () {
        //                   if (provider.currentTab !=
        //                       provider.categories?[index].id) {
        //                     provider.selectTab(index);
        //                   }
        //                 },
        //               );
        //             },
        //           ),
        //         ),
        //       ),
        //     ),
        //     secondChild: const SizedBox(),
        //     duration: const Duration(milliseconds: 500),
        //   );
        // }),

        Consumer<HomeProvider>(builder: (_, provider, child) {
          return provider.isGetProducts
              ? Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                  child: GridListAnimatorWidget(
                    physics: const NeverScrollableScrollPhysics(),
                    items: List.generate(
                      8,
                      (int index) {
                        return AnimationConfiguration.staggeredGrid(
                          columnCount: 2,
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          child: const ScaleAnimation(
                            child: FadeInAnimation(
                              child: CustomShimmerContainer(),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              : provider.products.isNotEmpty
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                      child: GridListAnimatorWidget(
                        items: List.generate(
                          provider.products.length,
                          (int index) {
                            return AnimationConfiguration.staggeredGrid(
                              columnCount: 2,
                              position: index,
                              duration: const Duration(milliseconds: 375),
                              child: ScaleAnimation(
                                child: FadeInAnimation(
                                  child: ProductCard(
                                    product: provider.products[index],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  : RefreshIndicator(
                      color: Styles.PRIMARY_COLOR,
                      onRefresh: () async {
                        provider.getProducts();
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                        child: ListAnimator(
                          data: [
                            EmptyState(
                              imgWidth: 215.w,
                              imgHeight: 220.h,
                              spaceBtw: 12,
                              txt: "لا يوجد خدمات الان",
                              subText: "تابعنا حتي تستفاد بخدمتنا الجديدة",
                            ),
                          ],
                        ),
                      ),
                    );
        }),
      ],
    );
  }
}
