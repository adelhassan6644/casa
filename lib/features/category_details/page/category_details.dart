import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:casa/app/core/utils/color_resources.dart';
import 'package:casa/app/core/utils/dimensions.dart';
import 'package:casa/app/core/utils/extensions.dart';
import 'package:casa/components/animated_widget.dart';
import 'package:casa/components/empty_widget.dart';
import 'package:casa/components/shimmer/custom_shimmer.dart';
import 'package:casa/features/category_details/provider/category_details_provider.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/grid_list_animator.dart';
import '../../../main_widgets/place_card.dart';

class CategoryDetails extends StatefulWidget {
  final int id;
  const CategoryDetails({Key? key, required this.id}) : super(key: key);

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Provider.of<CategoryDetailsProvider>(context, listen: false).model = null;
      Provider.of<CategoryDetailsProvider>(context, listen: false)
          .getCategoryDetails(widget.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.BACKGROUND_COLOR,
      body: SafeArea(
        bottom: true,
        top: true,
        child: Consumer<CategoryDetailsProvider>(
          builder: (context, provider, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomAppBar(),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                  child: provider.isLoading
                      ? const CustomShimmerContainer(
                          width: 150,
                          height: 30,
                        )
                      : Text(provider.model?.data?.title ?? "",
                          style: AppTextStyles.semiBold.copyWith(
                              fontSize: 24,
                              color: provider.model?.data?.textColor?.toColor)),
                ),
                provider.isLoading
                    ? Expanded(
                        child: Padding(
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
                        ),
                      )
                    : provider.model != null &&
                            provider.model!.data != null &&
                            provider.model!.data!.places != null &&
                            provider.model!.data!.places != null &&
                            provider.model!.data!.places!.isNotEmpty
                        ? Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      Dimensions.PADDING_SIZE_DEFAULT.w),
                              child: GridListAnimatorWidget(
                                items: List.generate(
                                  provider.model!.data!.places!.length,
                                  (int index) {
                                    return AnimationConfiguration.staggeredGrid(
                                      columnCount: 2,
                                      position: index,
                                      duration:
                                          const Duration(milliseconds: 375),
                                      child: ScaleAnimation(
                                        child: FadeInAnimation(
                                          child: PlaceCard(
                                            place: provider
                                                .model!.data!.places![index],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          )
                        : Expanded(
                            child: RefreshIndicator(
                              color: Styles.PRIMARY_COLOR,
                              onRefresh: () async {
                                provider.getCategoryDetails(widget.id);
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
                                      txt: "لا يوجد اماكن الان",
                                      subText: "اكتشف معانا اماكن جديدة",
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
              ],
            );
          },
        ),
      ),
    );
  }
}
