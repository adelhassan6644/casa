import 'package:flutter/material.dart';
import 'package:casa/app/core/utils/extensions.dart';
import 'package:casa/features/home/provider/home_provider.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/animated_widget.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_images.dart';
import '../../../components/custom_network_image.dart';

class News extends StatelessWidget {
  const News({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.BACKGROUND_COLOR,
      body: SafeArea(
        bottom: true,
        top: true,
        child: Consumer<HomeProvider>(
          builder: (context, provider, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomAppBar(),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                  child: Text("الأخبار",
                      style: AppTextStyles.semiBold.copyWith(
                          fontSize: 24, color: Styles.HEADER)),
                ),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(top: 16.h),
                  child: ListAnimator(
                    data: List.generate(
                        provider.newsModel?.news?.length ?? 0,
                        (index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                margin: EdgeInsets.only(
                                  bottom: 16.h,
                                  left: Dimensions.PADDING_SIZE_DEFAULT.w,
                                  right: Dimensions.PADDING_SIZE_DEFAULT.w,
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 16.h),
                                decoration: BoxDecoration(
                                    color: Styles.WHITE_COLOR,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                          offset: const Offset(2, 2),
                                          color: Colors.black.withOpacity(0.1),
                                          spreadRadius: 3,
                                          blurRadius: 10)
                                    ]),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      provider.newsModel?.news?[index].title ??
                                          "",
                                      style: AppTextStyles.medium.copyWith(
                                        fontSize: 22,
                                        color: Styles.TITLE,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Text(
                                        provider.newsModel?.news?[index]
                                                .content ??
                                            "",
                                        style: AppTextStyles.medium.copyWith(
                                          fontSize: 16,
                                          color: Styles.DETAILS_COLOR,
                                        )),
                                    SizedBox(
                                      height: 18.h,
                                    ),
                                    Row(
                                      children: [
                                        customImageIconSVG(
                                            imageName: SvgImages.location,
                                            height: 20,
                                            width: 20,
                                            color: Styles.TITLE),
                                        SizedBox(
                                          width: 8.w,
                                        ),
                                        Expanded(
                                          child: Text(
                                            provider.newsModel?.news?[index]
                                                    .address ??
                                                "address",
                                            maxLines: 1,
                                            style: AppTextStyles.medium
                                                .copyWith(
                                                    fontSize: 16,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    color:
                                                        Styles.TITLE),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                    CustomNetworkImage.containerNewWorkImage(
                                        image: provider.offersModel
                                                ?.data?[index].image ??
                                            "",
                                        width: context.width,
                                        height: 180.h,
                                        fit: BoxFit.cover,
                                        radius: 20),
                                  ],
                                ),
                              ),
                            )),
                  ),
                ))
              ],
            );
          },
        ),
      ),
    );
  }
}
