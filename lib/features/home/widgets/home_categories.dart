import 'package:flutter/material.dart';
import 'package:casa/app/core/utils/styles.dart';
import 'package:casa/app/core/utils/dimensions.dart';
import 'package:casa/app/core/utils/extensions.dart';
import 'package:casa/app/core/utils/text_styles.dart';
import 'package:casa/components/custom_network_image.dart';
import 'package:casa/components/shimmer/custom_shimmer.dart';
import 'package:casa/features/home/provider/home_provider.dart';
import 'package:casa/navigation/custom_navigation.dart';
import 'package:casa/navigation/routes.dart';
import 'package:provider/provider.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (_, provider, child) {
      return provider.isGetCategories
          ? SizedBox(
              height: 90,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: Dimensions.PADDING_SIZE_DEFAULT.w,
                  ),
                  Expanded(
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (_, index) => const _CategoryItemShimmer(),
                        separatorBuilder: (_, index) => SizedBox(
                              width: 12.w,
                            ),
                        itemCount: 5),
                  ),
                ],
              ),
            )
          : provider.categoriesModel != null &&
                  provider.categoriesModel?.data != null &&
                  provider.categoriesModel!.data!.isNotEmpty
              ? SizedBox(
                  height: 90,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: Dimensions.PADDING_SIZE_DEFAULT.w,
                      ),
                      Expanded(
                        child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (_, index) => _CategoryItem(
                                  id: provider
                                          .categoriesModel?.data?[index].id ??
                                      0,
                                  title: provider
                                      .categoriesModel?.data?[index].title,
                                  image: provider
                                      .categoriesModel?.data?[index].image,
                                  color: provider
                                      .categoriesModel?.data?[index].color,
                                  textColor: provider
                                      .categoriesModel?.data?[index].textColor,
                                ),
                            separatorBuilder: (_, index) => SizedBox(
                                  width: 12.w,
                                ),
                            itemCount:
                                provider.categoriesModel?.data?.length ?? 0),
                      ),
                    ],
                  ),
                )
              : const SizedBox();
    });
  }
}

class _CategoryItem extends StatelessWidget {
  final String? title, image, textColor, color;
  final int id;

  const _CategoryItem(
      {Key? key,
      this.title,
      this.image,
      required this.id,
      this.textColor,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      onTap: () {
        CustomNavigator.push(Routes.CATEGORY_DETAILS, arguments: id);
      },
      child: Column(
        children: [
          CustomNetworkImage.circleNewWorkImage(
            radius: 27.5,
            padding: 12,
            backGroundColor: color?.toColor,
            image: image,
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            title ?? "",
            style: AppTextStyles.medium.copyWith(
                fontSize: 14,
                color: textColor?.toColor ?? Styles.HEADER),
          ),
        ],
      ),
    );
  }
}

class _CategoryItemShimmer extends StatelessWidget {
  const _CategoryItemShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomShimmerCircleImage(
          diameter: 55,
        ),
        SizedBox(
          height: 8.h,
        ),
        const CustomShimmerContainer(
          width: 100,
          height: 15,
        )
      ],
    );
  }
}
