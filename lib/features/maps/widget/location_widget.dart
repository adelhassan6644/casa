import 'package:casa/app/core/utils/svg_images.dart';
import 'package:casa/components/custom_images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:casa/app/core/utils/dimensions.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/custom_button.dart';
import '../../../navigation/custom_navigation.dart';
import '../../address/provider/addresses_provider.dart';
import '../provider/map_provider.dart';

class LocationCard extends StatelessWidget {
  const LocationCard({Key? key, this.valueChanged}) : super(key: key);
  final Function(dynamic)? valueChanged;
  @override
  Widget build(BuildContext context) {
    return Consumer<MapProvider>(builder: (c, locationController, _) {
      return Container(
          height: 280.h,
          padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: Styles.WHITE_COLOR,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 5.0,
                  spreadRadius: -1,
                  offset: const Offset(0, 6))
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 6.h,
              ),
              Center(
                child: Container(
                  height: 5,
                  width: 60,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                    color: Styles.BORDER_COLOR,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 16.h,
                ),
                child: Row(
                  children: [
                    customImageIconSVG(
                        imageName: SvgImages.location,
                        color: Styles.PRIMARY_COLOR,
                        height: 20,
                        width: 20),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      getTranslated("address", context),
                      style: AppTextStyles.medium
                          .copyWith(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
              Text(
                locationController.pickAddress,
                maxLines: 2,
                style: AppTextStyles.regular.copyWith(
                    color: Colors.black,
                    overflow: TextOverflow.ellipsis,
                    fontSize: 13),
              ),
              SizedBox(
                height: 16.h,
              ),
              Consumer<AddressesProvider>(builder: (_, addressProvider, child) {
                return Row(
                  children: [
                    Text(
                      getTranslated("address_type", context),
                      style: AppTextStyles.medium
                          .copyWith(fontSize: 18, color: Styles.PRIMARY_COLOR),
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    _AddressType(
                      title: addressProvider.types[0],
                      isSelected: addressProvider.type == 0,
                      onTap: () => addressProvider.selectType(0),
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    _AddressType(
                      title: addressProvider.types[1],
                      isSelected: addressProvider.type == 1,
                      onTap: () => addressProvider.selectType(1),
                    )
                  ],
                );
              }),
              const Expanded(child: SizedBox()),
              !locationController.isLoading
                  ? Consumer<AddressesProvider>(builder: (_, provider, child) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 24.h),
                        child: CustomButton(
                          isLoading: provider.isAdding,
                          text: getTranslated("confirm_location", context),
                          onTap: () {
                            if (valueChanged != null) {
                              valueChanged!(locationController.addressModel!);
                            }
                            CustomNavigator.pop();
                          },
                        ),
                      );
                    })
                  : Padding(
                      padding: EdgeInsets.only(bottom: 50.h),
                      child: const Center(child: CupertinoActivityIndicator()),
                    ),
              SizedBox(
                height: 12.h,
              ),
            ],
          ));
    });
  }
}

class _AddressType extends StatelessWidget {
  const _AddressType(
      {Key? key, required this.title, required this.isSelected, this.onTap})
      : super(key: key);
  final String title;
  final bool isSelected;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_SMALL.w,
          vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL.h,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isSelected
              ? Styles.PRIMARY_COLOR
              : Styles.PRIMARY_COLOR.withOpacity(0.1),
        ),
        child: Text(
          getTranslated(title, context),
          style: AppTextStyles.regular.copyWith(
            fontSize: 14,
            color: isSelected ? Styles.WHITE_COLOR : Styles.PRIMARY_COLOR,
          ),
        ),
      ),
    );
  }
}
