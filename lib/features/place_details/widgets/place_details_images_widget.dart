import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:casa/app/core/utils/dimensions.dart';
import 'package:casa/app/core/utils/extensions.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../components/custom_network_image.dart';
import '../provider/place_details_provider.dart';

class PlaceDetailsImagesWidget extends StatelessWidget {
  final List<String> images;
  const PlaceDetailsImagesWidget({Key? key, required this.images})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return images.isEmpty
        ? CustomNetworkImage.containerNewWorkImage(
            image: "",
            width: context.width,
            height: context.height,
            fit: BoxFit.fitWidth,
            radius: 0)
        : Consumer<PlaceDetailsProvider>(builder: (context, provider, child) {
            return CarouselSlider.builder(
              options: CarouselOptions(
                viewportFraction: 1,
                autoPlay: false,
                height: context.height,
                enlargeCenterPage: false,
                disableCenter: true,
                pageSnapping: true,
                onPageChanged: (index, reason) {
                  provider.setPlacesIndex(index);
                },
              ),
              disableGesture: true,
              itemCount: images.length,
              itemBuilder: (context, index, _) {
                return CustomNetworkImage.containerNewWorkImage(
                    image: images[index],
                    width: context.width,
                    fit: BoxFit.fitWidth,
                    height: context.height,
                    radius: 0);
              },
            );
          });
  }
}
