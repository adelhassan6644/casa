import 'package:flutter/material.dart';
import 'package:casa/app/core/utils/dimensions.dart';
import 'package:casa/app/core/utils/extensions.dart';
import 'package:casa/components/shimmer/custom_shimmer.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_network_image.dart';
import '../provider/setting_provider.dart';

class DeveloperImage extends StatelessWidget {
  const DeveloperImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingProvider>(builder: (_, provider, child) {
      return Column(
        children: [
          Stack(
            children: [
              Container(
                height: 160 + context.toPadding,
                width: context.width,
                margin: const EdgeInsets.only(bottom: 50),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(Images.profileBGImage),
                        fit: BoxFit.fitHeight)),
                child: const SizedBox(),
              ),
              Column(
                children: [
                  const CustomAppBar(),
                  provider.isLoading
                      ? const CustomShimmerCircleImage(
                          diameter: 68 * 2,
                        )
                      : CustomNetworkImage.circleNewWorkImage(
                          color: Styles.HINT_COLOR,
                          image: provider.model?.data?.image ?? "",
                          radius: 68),
                ],
              ),
            ],
          ),
          Center(
            child: provider.isLoading
                ? const CustomShimmerContainer(
                    height: 15,
                    width: 200,
                  )
                : Text(
                    provider.model?.data?.name ?? "",
                    style: AppTextStyles.medium
                        .copyWith(color: const Color(0xFFF8A14E), fontSize: 16),
                  ),
          ),
          SizedBox(
            height: 24.h,
          ),
        ],
      );
    });
  }
}
