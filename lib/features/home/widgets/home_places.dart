import 'package:flutter/material.dart';
import 'package:casa/app/core/utils/dimensions.dart';
import 'package:casa/features/home/provider/home_provider.dart';
import 'package:casa/main_widgets/place_card.dart';
import 'package:provider/provider.dart';

import '../../../components/shimmer/custom_shimmer.dart';

class HomePlaces extends StatelessWidget {
  const HomePlaces({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Consumer<HomeProvider>(builder: (_, provider, child) {
        return provider.isGetPlaces
            ? SizedBox(
                height: 232.h,
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
                          itemBuilder: (_, index) => CustomShimmerContainer(
                                height: 220.h,
                                width: 210.w,
                              ),
                          separatorBuilder: (_, index) => SizedBox(
                                width: 12.w,
                              ),
                          itemCount: 5),
                    ),
                  ],
                ),
              )
            : provider.placesModel != null &&
                    provider.placesModel?.data != null &&
                    provider.placesModel!.data!.isNotEmpty
                ? SizedBox(
                    height: 232.h,
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
                              itemBuilder: (_, index) => PlaceCard(
                                  place: provider.placesModel!.data![index]),
                              separatorBuilder: (_, index) => SizedBox(
                                    width: 12.w,
                                  ),
                              itemCount: provider.placesModel!.data!.length),
                        ),
                      ],
                    ),
                  )
                : const SizedBox();
      }),
    );
  }
}
