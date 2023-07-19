import 'package:carousel_slider/carousel_slider.dart';
import 'package:casa/app/core/utils/color_resources.dart';
import 'package:casa/app/core/utils/dimensions.dart';
import 'package:casa/app/core/utils/extensions.dart';
import 'package:flutter/material.dart';

import '../../../navigation/custom_navigation.dart';
import '../../../components/custom_network_image.dart';
import '../app/core/utils/text_styles.dart';

class ImagesSlider extends StatefulWidget {
  const ImagesSlider({
    Key? key,
    required this.images,
    required this.title,
    this.isFromInternet = false,
  }) : super(key: key);

  final dynamic images;
  final String title;
  final bool isFromInternet;

  @override
  State<ImagesSlider> createState() => _ImagesSliderState();
}

class _ImagesSliderState extends State<ImagesSlider> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Positioned(
          top: 24.h,
          right: 24.w,
          child: GestureDetector(
            onTap: () {
              CustomNavigator.pop();
            },
            child: Container(
              width: 35.w,
              height: 35.h,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  color: Styles.WHITE_COLOR,
                  borderRadius: BorderRadius.circular(40)),
              child: Center(
                child: Icon(
                  Icons.close,
                  size: 24,
                  color: Colors.black.withOpacity(0.9),
                ),
              ),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: AppTextStyles.semiBold.copyWith(
                  fontSize: 16,
                  overflow: TextOverflow.ellipsis,
                  color: Styles.WHITE_COLOR),
            ),
            CarouselSlider.builder(
              itemCount: widget.images!.length,
              options: CarouselOptions(
                onPageChanged: (index, _) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                height: 205.h,
                autoPlay: false,
                aspectRatio: 0.80,
                viewportFraction: 0.70,
                autoPlayInterval: const Duration(seconds: 5),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
              ),
              itemBuilder: (context, index, i) {
                final double imageSize = context.width;
                return Container(
                  width: context.width,
                  height: 205.h,
                  padding: EdgeInsets.only(right: 0, left: 4.w, top: 16.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Stack(
                    children: [
                      CustomNetworkImage.containerNewWorkImage(
                          image: widget.images[index],
                          width: imageSize,
                          height: 205.h,
                          fit: BoxFit.cover),
                    ],
                  ),
                );
              },
            ),
            SizedBox(
              height: 52.h,
              child: ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 24.h, bottom: 24.h),
                  itemCount: widget.images!.length,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) => SizedBox(width: 4.w),
                  itemBuilder: (context, index) {
                    final isSelected = index == _currentIndex;
                    return _buildDotIndicator(isSelected);
                  }),
            )
          ],
        ),
      ],
    );
  }

  Widget _buildDotIndicator(bool isActive) {
    return Container(
      width: 32.w,
      height: 4.h,
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        color:
            isActive ? Styles.PRIMARY_COLOR : const Color(0xFFDDE5EB),
        borderRadius: BorderRadius.circular(6.0),
      ),
    );
  }
}
