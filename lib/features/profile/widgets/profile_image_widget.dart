import 'package:flutter/material.dart';
import 'package:casa/features/profile/provider/profile_provider.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../components/custom_images.dart';
import '../../../components/custom_network_image.dart';
import '../../../components/image_pop_up_viewer.dart';
import '../../../helpers/image_picker_helper.dart';

class ProfileImageWidget extends StatelessWidget {
  const ProfileImageWidget({required this.withEdit, this.radius = 68, Key? key})
      : super(key: key);
  final bool withEdit;
  final double radius;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<ProfileProvider>(builder: (_, provider, child) {
        return Column(
          children: [
            GestureDetector(
              onTap: () {
                if (provider.profileImage != null ||
                    provider.profileModel?.image != null) {
                  showDialog(
                      context: context,
                      barrierColor: Colors.black.withOpacity(0.75),
                      builder: (context) {
                        return ImagePopUpViewer(
                          image: provider.profileImage ??
                              provider.profileModel?.image ??
                              "",
                          isFromInternet:
                              provider.profileImage != null ? false : true,
                          title: "",
                        );
                      });
                }
              },
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  provider.profileImage != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.file(
                            provider.profileImage!,
                            height: radius * 2,
                            width: radius * 2,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Center(
                                    child: Container(
                                        height: radius * 2,
                                        width: radius * 2,
                                        color: Colors.grey,
                                        child: const Center(
                                            child: Icon(Icons.replay,
                                                color: Colors.green)))),
                          ),
                        )
                      : CustomNetworkImage.circleNewWorkImage(
                          color: Styles.HINT_COLOR,
                          image: provider.profileModel?.image ?? "",
                          radius: radius),
                  if (withEdit)
                    InkWell(
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        if (withEdit) {
                          ImagePickerHelper.showOptionSheet(
                              onGet: provider.onSelectImage);
                        }
                      },
                      child: Container(
                          height: 35,
                          width: 35,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              boxShadow: kElevationToShadow[1],
                              color: Styles.WHITE_COLOR,
                              borderRadius: BorderRadius.circular(100)),
                          child: customImageIconSVG(
                            imageName: SvgImages.cameraIcon,
                          )),
                    ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
