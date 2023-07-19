import 'package:flutter/cupertino.dart';

import '../../../app/core/utils/color_resources.dart';

class StepWidget extends StatelessWidget {
  const StepWidget({Key? key, required this.currentIndex}) : super(key: key);
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedContainer(
          height: 12,
          width: currentIndex == 0 ? 24 : 16,
          decoration: BoxDecoration(
              color: currentIndex == 0
                  ? Styles.PRIMARY_COLOR
                  : Styles.SECOUND_PRIMARY_COLOR,
              borderRadius: BorderRadius.circular(6)),
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOutSine,
        ),
        const SizedBox(
          width: 10,
        ),
        AnimatedContainer(
          height: 12,
          width: currentIndex == 1 ? 24 : 16,
          decoration: BoxDecoration(
              color: currentIndex == 1
                  ? Styles.PRIMARY_COLOR
                  : Styles.SECOUND_PRIMARY_COLOR,
              borderRadius: BorderRadius.circular(6)),
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOutSine,
        ),
      ],
    );
  }
}
