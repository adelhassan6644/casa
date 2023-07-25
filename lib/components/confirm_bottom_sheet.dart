import 'package:casa/app/core/utils/dimensions.dart';
import 'package:casa/app/core/utils/extensions.dart';
import 'package:casa/app/core/utils/text_styles.dart';
import 'package:casa/app/localization/localization/language_constant.dart';
import 'package:casa/components/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../app/core/utils/styles.dart';
import '../navigation/custom_navigation.dart';
import 'animated_widget.dart';

abstract class CustomBottomSheet {
  static show({
    Function? onConfirm,
    String? label,
    String? buttonText,
    required Widget? list,
    double? height,
    Widget? child,
    BuildContext? context,
  }) {
    return showMaterialModalBottomSheet(
      enableDrag: true,
      clipBehavior: Clip.antiAlias,
      backgroundColor: Colors.transparent,
      context: CustomNavigator.navigatorState.currentContext!,
      expand: false,
      useRootNavigator: true,
      isDismissible: true,
      builder: (_) {
        return Padding(
          padding: MediaQuery.of(CustomNavigator.navigatorState.currentContext!)
              .viewInsets,
          child: Container(
            height: height ?? 500,
            width: CustomNavigator.navigatorState.currentContext!.width,
            decoration: const BoxDecoration(
              color: Styles.WHITE_COLOR,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10.0, 0,0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 1.h),
                          child: Container(
                            height: 5.h,
                            width: 50.w,
                            decoration: const BoxDecoration(
                                color: Styles.BORDER_COLOR,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0))),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.PADDING_SIZE_DEFAULT.w, vertical: 16.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                label ?? "",
                                style: AppTextStyles.medium.copyWith(
                                  fontSize: 18,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  CustomNavigator.pop();
                                },
                                child: const Icon(
                                  Icons.highlight_remove,
                                  size: 24,
                                  color: Styles.DISABLED,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: 16.h,
                            right: 24.w,
                            left: 24.w,
                          ),
                          child: const Divider(color: Styles.BORDER_COLOR,),
                        ),
                        Expanded(
                            child: ListAnimator(
                          data: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24.w),
                              child: list!,
                            )
                          ],
                        )),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: child != null || onConfirm != null,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                        vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
                    child: child ??
                        CustomButton(
                          text: getTranslated(buttonText??"confirm",
                              CustomNavigator.navigatorState.currentContext!),
                          onTap: () {
                            onConfirm!();
                          },
                        ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }


// Future<T?> customDraggableScrollableSheet<T>(
//     {required Widget? body, Function()? onClose}) {
//   return showMaterialModalBottomSheet(
//       enableDrag: true,
//       clipBehavior: Clip.antiAlias,
//       backgroundColor: Colors.transparent,
//       context: CustomNavigator.navigatorState.currentContext!,
//       expand: false,
//       useRootNavigator: true,
//       isDismissible: true,
//       builder: (_) {
//         return DraggableScrollableSheet(
//           initialChildSize: 0.6, //set this as you want
//           maxChildSize: 0.9, //set this as you want
//           minChildSize: 0.6, //set this as you want
//           expand: true,
//           builder: (BuildContext context, ScrollController scrollController) {
//             return Expanded(
//               child: ListView(
//                 controller: scrollController,
//                 children: [
//                   Padding(
//                     padding: MediaQuery.of(
//                             CustomNavigator.navigatorState.currentContext!)
//                         .viewInsets,
//                     child: body!(scrollController),
//                   )
//                 ],
//               ),
//             );
//           },
//         );
//       }).then((value) => onClose != null ? onClose() : () {});
// }

}

class CustomModelSheet<T> {
  final int? id;
  final String? relatedId;
  final String? name;
  final String? value;
  bool? isSelected;
  final dynamic list;
  CustomModelSheet(
      {this.id,
        this.relatedId,
        this.list,
        this.name,
        this.isSelected = false,
        this.value});

  toJson() {
    var data = {};
    data["id"] = id;
    data["name"] = name;
    data["value"] = value;
    return data;
  }
}