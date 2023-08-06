import 'package:casa/app/localization/localization/language_constant.dart';
import 'package:casa/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:casa/app/core/utils/styles.dart';
import 'package:casa/app/core/utils/dimensions.dart';
import 'package:casa/components/animated_widget.dart';
import 'package:casa/components/empty_widget.dart';
import 'package:casa/components/shimmer/custom_shimmer.dart';
import 'package:casa/features/favourite/provider/favourite_provider.dart';
import 'package:casa/features/guest/guest_mode.dart';
import 'package:provider/provider.dart';
import '../../../components/grid_list_animator.dart';
import '../../../mian_widgets/product_card.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  void initState() {
    Future.delayed(
        Duration.zero,
        () => Provider.of<FavouriteProvider>(context, listen: false)
            .getFavourites());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.SCAFFOLD_BG,
      body: Consumer<FavouriteProvider>(
        builder: (context, provider, child) {
          return SafeArea(
            child: Column(
              children: [
                CustomAppBar(
                  title: getTranslated("favourite", context),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        provider.isLogin
                            ? Expanded(
                                child: provider.isLoading
                                    ? GridListAnimatorWidget(
                                        items: List.generate(
                                          8,
                                          (int index) {
                                            return AnimationConfiguration
                                                .staggeredGrid(
                                                    columnCount: 2,
                                                    position: index,
                                                    duration: const Duration(
                                                        milliseconds: 375),
                                                    child: const ScaleAnimation(
                                                        child: FadeInAnimation(
                                                            child:
                                                                CustomShimmerContainer())));
                                          },
                                        ),
                                      )
                                    : provider.favouriteModel != null &&
                                            provider.favouriteModel!.data !=
                                                null &&
                                            provider.favouriteModel!.data!
                                                .isNotEmpty
                                        ? GridListAnimatorWidget(
                                            items: List.generate(
                                              provider
                                                  .favouriteModel!.data!.length,
                                              (int index) {
                                                return AnimationConfiguration
                                                    .staggeredGrid(
                                                        columnCount: 2,
                                                        position: index,
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    375),
                                                        child: ScaleAnimation(
                                                            child:
                                                                FadeInAnimation(
                                                                    child:
                                                                        ProductCard(
                                                          product: provider
                                                              .favouriteModel!
                                                              .data![index],
                                                        ))));
                                              },
                                            ),
                                          )
                                        : RefreshIndicator(
                                            color: Styles.PRIMARY_COLOR,
                                            onRefresh: () async {
                                              provider.getFavourites();
                                            },
                                            child: ListAnimator(
                                              data: [
                                                EmptyState(
                                                  imgWidth: 215.w,
                                                  imgHeight: 220.h,
                                                  spaceBtw: 12,
                                                  txt: "لا يوجد منتجات",
                                                  subText:
                                                      "اكتشف معانا منتجات جديدة",
                                                ),
                                              ],
                                            ),
                                          ))
                            : const Expanded(child: GuestMode()),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
