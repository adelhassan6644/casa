import 'package:flutter/cupertino.dart';
import 'package:casa/app/core/utils/color_resources.dart';
import 'package:casa/features/profile/provider/profile_provider.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/text_styles.dart';
import '../../profile/widgets/profile_image_widget.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(builder: (_, provider, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Row(
            children: [
              ProfileImageWidget(
                withEdit: false,
                radius: 28.5,
              ),
              Expanded(child: SizedBox()),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            provider.isLogin ? provider.nameTEC.text.trim() : "Guest",
            style: AppTextStyles.bold.copyWith(
                color: ColorResources.SPLASH_BACKGROUND_COLOR,
                fontSize: 16,
                height: 1),
          ),
          Text(
            provider.isLogin
                ? provider.emailTEC.text.trim()
                : "elhemdanih@casa.com",
            style: AppTextStyles.regular.copyWith(
                color: ColorResources.SPLASH_BACKGROUND_COLOR, fontSize: 12),
          ),
          const SizedBox(
            height: 24,
          ),
        ],
      );
    });
  }
}
