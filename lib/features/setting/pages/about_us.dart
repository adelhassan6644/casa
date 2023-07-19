import 'package:flutter/material.dart';
import 'package:casa/app/core/utils/color_resources.dart';
import '../../../components/animated_widget.dart';
import '../widgets/developer_description.dart';
import '../widgets/developer_image.dart';
import '../widgets/developer_information.dart';
import '../widgets/developer_social_media.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Styles.BACKGROUND_COLOR,
        body: SafeArea(
          bottom: true,
          top: false,
          child: Column(
            children: [
              Expanded(
                  child: ListAnimator(
                data: [
                  DeveloperImage(),
                  DeveloperDescription(),
                  DeveloperInformation(),
                  DeveloperSocialMedia(),
                  SizedBox(
                    height: 24,
                  )
                ],
              ))
            ],
          ),
        ));
  }
}
