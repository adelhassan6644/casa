import 'package:casa/app/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import '../app/core/utils/color_resources.dart';

class ErrorWidget extends StatelessWidget {
  final VoidCallback? onPress;

  const ErrorWidget({Key? key, this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Center(
          child: Icon(
            Icons.warning_amber_rounded,
            color: ColorResources.PRIMARY_COLOR,
            size: 150,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 12),
          child: const Text(
            ('something_went_wrong'),
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700),
          ),
        ),
        const Text(
          ('try_again'),
          style: TextStyle(
              color: ColorResources.HINT_COLOR,
              fontSize: 18,
              fontWeight: FontWeight.w500),
        ),
        Container(
          height: 55,
          width: context.width * 0.55,
          margin: const EdgeInsets.symmetric(vertical: 15),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 500,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50))),
            child: const Text(
              ('reload_screen'),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
            onPressed: () {
              if (onPress != null) {
                onPress!();
              }
            },
          ),
        )
      ],
    );
  }
}
