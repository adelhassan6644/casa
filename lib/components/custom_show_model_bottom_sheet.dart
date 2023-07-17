import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../navigation/custom_navigation.dart';

Future<T?> customShowModelBottomSheet<T>(
    {required Widget? body, bool? isDismissible,Function()? onClose}) {
  return showMaterialModalBottomSheet(
      enableDrag: true,
      clipBehavior: Clip.antiAlias,
      backgroundColor: Colors.transparent,
      context: CustomNavigator.navigatorState.currentContext!,
      expand: false,
      useRootNavigator: true,
      isDismissible: isDismissible ?? true,
      builder: (_) {
        return Padding(
          padding: MediaQuery.of(CustomNavigator.navigatorState.currentContext!)
              .viewInsets,
          child: body!,
        );
      }).then((value) => onClose != null ? onClose() : () {});
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
