import 'package:casa/navigation/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'custom_button.dart';

class RegularLocationPermissionDialog extends StatelessWidget {
  const RegularLocationPermissionDialog({Key? key}) : super(key: key);

  //
  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Column(
      children: [
        //title
        const Text("Location Permission"),
        const Text(
            "This app collects location data to enable system search for assignable order within your location and also allow customer track your location when decasaring their order."),

        CustomButton(
          text: "Next",
          onTap: () {},
        ),
        CustomButton(
          text: "Cancel",
          onTap: () {
            CustomNavigator.pop();
          },
        ),
      ],
    ) //.hTwoThird(context),
        );
  }
}
