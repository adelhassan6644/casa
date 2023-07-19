import 'package:casa/app/core/utils/color_resources.dart';
import 'package:casa/app/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import '../../app/core/utils/dimensions.dart';
import '../../navigation/custom_navigation.dart';
import '../app/core/utils/text_styles.dart';

class AuthAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? actionChild;
  final bool withBack;
  final double? actionWidth;

  const AuthAppBar(
      {Key? key,
      this.title,
      this.withBack = true,
      this.actionWidth,
      this.actionChild})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: context.toPadding + 24.h,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              actionChild ??
                  const SizedBox(
                    width: 18,
                  ),
              const Expanded(child: SizedBox()),
              Text(
                title ?? "",
                style: AppTextStyles.semiBold
                    .copyWith(color: Styles.WHITE_COLOR, fontSize: 14),
              ),
              const Expanded(child: SizedBox()),
              withBack
                  ? InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        CustomNavigator.pop();
                      },
                      child: SizedBox(
                        width: actionWidth ?? 18,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                              color: Styles.WHITE_COLOR,
                            ),
                          ],
                        ),
                      ))
                  : SizedBox(
                      width: actionWidth ?? 18,
                    ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size(15005, 50);
}
