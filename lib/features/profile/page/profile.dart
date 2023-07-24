import 'package:flutter/material.dart';
import 'package:casa/app/core/utils/dimensions.dart';
import 'package:casa/app/core/utils/extensions.dart';
import 'package:casa/components/animated_widget.dart';
import 'package:casa/features/guest/guest_mode.dart';
import 'package:casa/features/profile/widgets/profile_image_widget.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/images.dart';
import '../provider/profile_provider.dart';
import '../widgets/change_password_button.dart';
import '../widgets/profile_body.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(builder: (_, provider, child) {
      return SafeArea(
        bottom: true,
        top: false,
        child: Column(
          children: [
            Expanded(
                child: ListAnimator(
                  data: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          height: 160 + context.toPadding,
                          width: context.width,
                          margin: const EdgeInsets.only(bottom: 50),
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(Images.profileBGImage),
                                  fit: BoxFit.cover)),
                          child: const SizedBox(),
                        ),
                        const ProfileImageWidget(withEdit: true)
                      ],
                    ),
                    const ProfileBody(),
                    // const ChangePasswordButton()
                  ],
                ))
          ],
        )
      );
    });
  }
}
