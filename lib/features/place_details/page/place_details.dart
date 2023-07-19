import 'package:flutter/material.dart';
import 'package:casa/app/core/utils/color_resources.dart';
import 'package:casa/app/core/utils/extensions.dart';
import 'package:casa/components/custom_network_image.dart';
import 'package:casa/features/place_details/provider/place_details_provider.dart';
import 'package:casa/features/place_details/widgets/place_details_images_widget.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/dimensions.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/empty_widget.dart';
import '../widgets/place_details_widget.dart';

class PlaceDetails extends StatefulWidget {
  final int id;

  const PlaceDetails({Key? key, required this.id}) : super(key: key);

  @override
  State<PlaceDetails> createState() => _PlaceDetailsState();
}

class _PlaceDetailsState extends State<PlaceDetails> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Provider.of<PlaceDetailsProvider>(context, listen: false).model = null;
      Provider.of<PlaceDetailsProvider>(context, listen: false)
          .geDetails(widget.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.BACKGROUND_COLOR,
      body: SafeArea(
        top: false,
        child:
            Consumer<PlaceDetailsProvider>(builder: (context, provider, child) {
          return provider.isLoading
              ? Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    CustomNetworkImage.containerNewWorkImage(
                        image: "",
                        width: context.width,
                        height: context.height,
                        fit: BoxFit.fitWidth,
                        radius: 0),
                    const Column(
                      children: [
                        CustomAppBar(),
                        Expanded(child: SizedBox()),
                        PlaceDetailsWidgetShimmer(),
                      ],
                    ),
                  ],
                )
              : provider.model != null
                  ? Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        PlaceDetailsImagesWidget(
                            images: provider.model!.images!),
                        Column(
                          children: [
                            const CustomAppBar(),
                            const Expanded(child: SizedBox()),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: provider.model!.images!.map((place) {
                                int index =
                                    provider.model!.images!.indexOf(place);
                                return AnimatedContainer(
                                  width: index == provider.placesIndex ? 25 : 8,
                                  height: 8,
                                  duration: const Duration(
                                    milliseconds: 200,
                                  ),
                                  margin: EdgeInsets.symmetric(horizontal: 2.w),
                                  decoration: BoxDecoration(
                                      color: index == provider.placesIndex
                                          ? Styles.SECOUND_PRIMARY_COLOR
                                          : Styles.WHITE_COLOR,
                                      borderRadius:
                                          BorderRadius.circular(100.w),
                                      border: Border.all(
                                          color: Styles
                                              .SECOUND_PRIMARY_COLOR,
                                          width: 1)),
                                );
                              }).toList(),
                            ),
                            SizedBox(
                              height: 24.h,
                            ),
                            PlaceDetailsWidget(
                              placeItem: provider.model!,
                            ),
                          ],
                        ),
                      ],
                    )
                  : const EmptyState(
                      emptyHeight: 200,
                      imgHeight: 110,
                    );
        }),
      ),
    );
  }
}
