import 'package:casa/app/localization/localization/language_constant.dart';
import 'package:casa/components/shimmer/custom_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:casa/app/core/utils/extensions.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_simple_dialog.dart';
import '../../../components/empty_widget.dart';
import '../../../data/config/di.dart';
import '../provider/session_details_provider.dart';
import '../widgets/session_details_widget.dart';

class SessionDetails extends StatefulWidget {
  final int id;

  const SessionDetails({Key? key, required this.id}) : super(key: key);

  @override
  State<SessionDetails> createState() => _SessionDetailsState();
}

class _SessionDetailsState extends State<SessionDetails> {
  @override
  void initState() {
    Future.delayed(Duration.zero,
        () => sl<SessionDetailsProvider>().getSessionDetails(widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Consumer<SessionDetailsProvider>(
            builder: (context, provider, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(title: provider.model?.subService,withBack: true,),

              ///Session Details
              provider.isLoading
                  ? const _SessionDetailsWidgetShimmer()
                  : provider.model != null
                      ? SessionDetailsWidget(model: provider.model!)
                      : const EmptyState(),


            ],
          );
        }),
      ),
    );
  }
}

class _SessionDetailsWidgetShimmer extends StatelessWidget {
  const _SessionDetailsWidgetShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
        child: Column(
          children: [
            CustomShimmerContainer(
              height: 250.h,
              width: context.width,
              radius: 30,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                  vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///Session Name
                  const Row(
                    children: [
                      CustomShimmerContainer(
                        width: 200,
                        height: 16,
                      ),
                      Spacer(),
                      CustomShimmerContainer(
                        width: 100,
                        height: 16,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12.h,
                  ),

                  ///Location
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: const CustomShimmerContainer(
                      width: 100,
                      height: 16,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const CustomShimmerContainer(
                          width: 20,
                          height: 20,
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        const Expanded(
                          child: CustomShimmerContainer(
                            height: 16,
                          ),
                        ),
                      ],
                    ),
                  ),

                  ///Date
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: const CustomShimmerContainer(
                      width: 100,
                      height: 16,
                    ),
                  ),
                  CustomShimmerContainer(
                    width: context.width * 0.6,
                    height: 16,
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  CustomShimmerContainer(
                    width: context.width * 0.6,
                    height: 16,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
