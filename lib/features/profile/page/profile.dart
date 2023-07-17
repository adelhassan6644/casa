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
        child: provider.isLogin
            ? Column(
                children: [
                  Expanded(
                      child: ListAnimator(
                    data: [
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            height: 160 + context.toPadding,
                            width: context.width,
                            margin: const EdgeInsets.only(bottom: 68),
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(Images.profileBGImage),
                                    fit: BoxFit.fitHeight)),
                            child: const SizedBox(),
                          ),
                          const ProfileImageWidget(withEdit: true)
                        ],
                      ),
                      // const SizedBox(
                      //   height: 8,
                      // ),
                      // Center(
                      //   child: Text(
                      //     provider.profileModel?.name ?? "Mohamed Ahmed",
                      //     style: AppTextStyles.medium
                      //         .copyWith(color: Colors.black, fontSize: 16),
                      //   ),
                      // ),
                      SizedBox(
                        height: 30.h,
                      ),
                      const ProfileBody(),
                      const ChangePasswordButton()
                    ],
                  ))
                ],
              )
            : Padding(
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT.w),
                child: const GuestMode(),
              ),
      );
    });
  }
}
