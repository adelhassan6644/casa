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
import 'product_card.dart';

class HomeProducts extends StatelessWidget {
  const HomeProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (_,provider,child) {
        return provider.isGetProducts
            ? Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
              child: GridListAnimatorWidget(
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
            : provider.productsModel != null &&
            provider.productsModel!.data != null &&
            provider.productsModel!.data!.isNotEmpty
            ? Padding(
              padding: EdgeInsets.symmetric(
                  horizontal:
                  Dimensions.PADDING_SIZE_DEFAULT.w),
              child: GridListAnimatorWidget(
                items: List.generate(
                  provider.productsModel!.data!.length,
                      (int index) {
                    return AnimationConfiguration.staggeredGrid(
                      columnCount: 2,
                      position: index,
                      duration:
                      const Duration(milliseconds: 375),
                      child: ScaleAnimation(
                        child: FadeInAnimation(
                          child: ProductCard(
                            product: provider.productsModel!.data![index],
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
                    horizontal:
                    Dimensions.PADDING_SIZE_DEFAULT.w),
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
      }
    );
  }
}
