import 'package:casa/app/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../../app/core/utils/color_resources.dart';
import '../../app/core/utils/dimensions.dart';
import '../../app/core/utils/text_styles.dart';
import 'custom_images.dart';

class DynamicDropDownButton extends StatefulWidget {
  final List<dynamic> items;
  final Widget? icon;
  final String? pAssetIcon;
  final String? pSvgIcon;
  final Color? pIconColor;
  final double iconSize;
  final String? label;
  final String name;
  final dynamic value;
  final void Function(dynamic)? onChange;
  final void Function()? onTap;
  final String? Function(Object?)? validation;
  final bool? isInitial;

  const DynamicDropDownButton({
    required this.items,
    this.value,
    this.pAssetIcon,
    this.pSvgIcon,
    this.pIconColor,
    this.onChange,
    this.validation,
    this.icon,
    this.label,
    required this.name,
    this.onTap,
    this.isInitial = false,
    this.iconSize = 22,
    Key? key,
  }) : super(key: key);

  @override
  State<DynamicDropDownButton> createState() => _DynamicDropDownButtonState();
}

class _DynamicDropDownButtonState extends State<DynamicDropDownButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: FormBuilderDropdown(
        items: widget.items.map((dynamic item) {
          return DropdownMenuItem(
            value: item,
            child: Text(
              item.name,
              style: AppTextStyles.medium
                  .copyWith(color: Styles.TITLE, fontSize: 13),
            ),
          );
        }).toList(),
        onChanged: widget.onChange,
        onTap: widget.onTap,
        menuMaxHeight: context.height * 0.4,
        initialValue: widget.value,
        isDense: true,
        validator: widget.validation,
        isExpanded: true,
        dropdownColor: Styles.FILL_COLOR,
        itemHeight: 50,
        icon: widget.icon ??
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Styles.SECOUND_PRIMARY_COLOR,
            ),
        iconSize: widget.iconSize,
        borderRadius:
            const BorderRadius.all(Radius.circular(Dimensions.RADIUS_DEFAULT)),
        decoration: InputDecoration(
          hintStyle: widget.isInitial == true
              ? AppTextStyles.medium.copyWith(
                  color: Styles.SECOUND_PRIMARY_COLOR, fontSize: 14)
              : AppTextStyles.regular
                  .copyWith(color: Styles.DISABLED, fontSize: 14),
          hintText: widget.name,
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 8.w,
            ),
            child: widget.pAssetIcon != null
                ? Image.asset(
                    widget.pAssetIcon!,
                    height: 22.h,
                    width: 22.w,
                    color: widget.pIconColor ?? Colors.black,
                  )
                : widget.pSvgIcon != null
                    ? customImageIconSVG(
                        imageName: widget.pSvgIcon!,
                        color: widget.pIconColor ?? Colors.black,
                        height: 22.h,
                      )
                    : null,
          ),
          fillColor: Styles.FILL_COLOR,
          filled: true,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                Dimensions.RADIUS_DEFAULT,
              ),
            ),
            borderSide: BorderSide(
                color: Styles.LIGHT_BORDER_COLOR,
                width: 1,
                style: BorderStyle.solid),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                Dimensions.RADIUS_DEFAULT,
              ),
            ),
            borderSide: BorderSide(
                color: Styles.SECOUND_PRIMARY_COLOR,
                width: 1,
                style: BorderStyle.solid),
          ),
          disabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                Dimensions.RADIUS_DEFAULT,
              ),
            ),
            borderSide: BorderSide(
                color: Styles.LIGHT_BORDER_COLOR,
                width: 1,
                style: BorderStyle.solid),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                Dimensions.RADIUS_DEFAULT,
              ),
            ),
            borderSide: BorderSide(
                color: Styles.LIGHT_BORDER_COLOR,
                width: 1,
                style: BorderStyle.solid),
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                Dimensions.RADIUS_DEFAULT,
              ),
            ),
            borderSide: BorderSide(
                color: Styles.FAILED_COLOR,
                width: 1,
                style: BorderStyle.solid),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                Dimensions.RADIUS_DEFAULT,
              ),
            ),
            borderSide: BorderSide(
                color: Styles.FAILED_COLOR,
                width: 1,
                style: BorderStyle.solid),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 25.h,
          ),
          labelText: widget.label,
          errorStyle: AppTextStyles.medium
              .copyWith(color: Styles.FAILED_COLOR, fontSize: 11),
          labelStyle: AppTextStyles.regular
              .copyWith(color: Styles.DISABLED, fontSize: 14),
        ),
        style: AppTextStyles.medium
            .copyWith(color: Styles.PRIMARY_COLOR, fontSize: 14),
        name: widget.name,
        elevation: 1,
      ),
    );
  }
}
