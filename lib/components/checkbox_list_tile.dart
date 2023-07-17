import 'package:casa/app/core/utils/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:casa/app/core/utils/dimensions.dart';
import '../../app/core/utils/text_styles.dart';

class CheckBoxListTile extends StatelessWidget {
  const CheckBoxListTile({
    Key? key,
    this.check = false,
    required this.title,
    this.description,
    required this.onChange,
  }) : super(key: key);
  final bool check;
  final String title;
  final String? description;
  final Function(bool) onChange;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChange(!check),
      child: Row(
        children: [
          Container(
            width: 18.w,
            height: 18.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: ColorResources.WHITE_COLOR,
                border: Border.all(
                    color: check
                        ? ColorResources.SECOUND_PRIMARY_COLOR
                        : ColorResources.DISABLED,
                    width: 1)),
            child: check
                ? const Icon(
                    Icons.check,
                    color: ColorResources.SECOUND_PRIMARY_COLOR,
                    size: 14,
                  )
                : null,
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.medium.copyWith(
                  fontSize: 14,
                  color: check
                      ? ColorResources.SECOUND_PRIMARY_COLOR
                      : ColorResources.DISABLED),
            ),
          ),
          if (description != null)
            Text(
              description!,
              style: AppTextStyles.bold.copyWith(
                  fontSize: 10,
                  color: check
                      ? ColorResources.SECOUND_PRIMARY_COLOR
                      : ColorResources.SUBTITLE),
            )
        ],
      ),
    );
  }
}
