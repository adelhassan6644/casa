import 'package:casa/app/core/utils/dimensions.dart';
import 'package:casa/app/core/utils/svg_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:casa/app/core/utils/text_styles.dart';
import '../../app/core/utils/styles.dart';
import 'custom_images.dart';

class CustomTextFormField extends StatefulWidget {
  final String? hint;
  final String? initialValue;
  final Widget? sufWidget;
  final Widget? prefixWidget;
  final bool label;
  final TextInputType? inputType;
  final String? Function(String?)? valid;
  final AutovalidateMode? validationMode;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final void Function(String)? onChanged;
  final String? sufSvgIcon, sufAssetIcon;
  final String? pAssetIcon;
  final String? pSvgIcon;
  final Color? pIconColor, sIconColor;
  final FocusNode? focus;
  final bool? read;
  final bool withPadding, isPassword, addBorder;
  final VoidCallback? edit;

  final List<TextInputFormatter>? formatter;
  final int? maxLength;
  final Color? fieldColor;
  final int? maxLine;
  final int? minLine;
  final TextInputAction keyboardAction;
  final AutovalidateMode autoValidateMode;
  final TextAlign? textAlign;
  final void Function(String?)? onSaved;

  const CustomTextFormField({
    super.key,
    this.withPadding = true,
    this.addBorder = true,
    this.keyboardAction = TextInputAction.next,
    this.autoValidateMode = AutovalidateMode.onUserInteraction,
    this.prefixWidget,
    this.initialValue,
    this.maxLine = 1,
    this.minLine = 1,
    this.hint,
    this.sufWidget,
    this.onTap,
    this.onChanged,
    this.inputType,
    this.valid,
    this.controller,
    this.focus,
    this.sufSvgIcon,
    this.sufAssetIcon,
    this.label = false,
    this.isPassword = false,
    this.read,
    this.edit,
    this.validationMode,
    this.formatter,
    this.maxLength,
    this.pAssetIcon,
    this.pSvgIcon,
    this.pIconColor,
    this.sIconColor,
    this.fieldColor,
    this.textAlign,
    this.onSaved,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  final InputBorder _borders = OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: const BorderSide(
      style: BorderStyle.solid,
      color: Styles.PRIMARY_COLOR,
      width: 1,
    ),
  );
  bool _isHidden = true;

  void _visibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: widget.withPadding ? 6.h : 0),
      child: TextFormField(
        onFieldSubmitted: widget.onSaved,
        textAlign: widget.textAlign ?? TextAlign.start,
        autovalidateMode: widget.autoValidateMode,
        textInputAction: widget.keyboardAction,
        onTap: widget.onTap,
        validator: widget.valid,
        controller: widget.controller,
        initialValue: widget.initialValue,
        maxLength: widget.maxLength,
        focusNode: widget.focus,
        readOnly: widget.read == true ? true : false,
        maxLines: widget.maxLine,
        minLines: widget.minLine ?? 1,
        keyboardType: widget.inputType,
        inputFormatters: widget.inputType == TextInputType.phone
            ? [FilteringTextInputFormatter.allow(RegExp('[0-9]'))]
            : widget.formatter,
        style: AppTextStyles.medium
            .copyWith(color: Styles.TITLE, fontSize: 14),
        cursorColor: Styles.TITLE,
        onChanged: widget.onChanged,
        obscureText: widget.isPassword == true ? _isHidden : false,
        decoration: InputDecoration(
          counterText: "",
          prefixIcon: Row(
            children: [
              SizedBox(
                width: 24.w,
              ),
              widget.prefixWidget ??
                  (widget.pAssetIcon != null
                      ? Image.asset(
                          widget.pAssetIcon!,
                          height: 16.h,
                          width: 16.w,
                          color: widget.pIconColor,
                        )
                      : widget.pSvgIcon != null
                          ? customImageIconSVG(
                              imageName: widget.pSvgIcon!,
                              color: widget.pIconColor??Styles.DETAILS_COLOR,
                              height: 16.h,
                              width: 16.w,
                            )
                          : const SizedBox()),
              const Expanded(child: SizedBox()),
              Container(
                height: 100,
                width: 1,
                decoration: BoxDecoration(
                    color: Styles.DISABLED,
                    borderRadius: BorderRadius.circular(100)),
                child: const SizedBox(),
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
          suffixIcon: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 8.w,
            ),
            child: widget.sufWidget ??
                (widget.sufAssetIcon != null
                    ? Image.asset(
                        widget.sufAssetIcon!,
                        height: 22.h,
                        color: widget.sIconColor,
                      )
                    : widget.sufSvgIcon != null
                        ? customImageIconSVG(
                            imageName: widget.sufSvgIcon!,
                            color: widget.sIconColor,
                            height: 16.h,
                          )
                        : widget.isPassword == true
                            ? IconButton(
                                padding: const EdgeInsets.all(0),
                                onPressed: _visibility,
                                alignment: Alignment.center,
                                icon: _isHidden
                                    ? customImageIconSVG(
                                        imageName: SvgImages.hiddenEyeIcon,
                                        height: 16.55.h,
                                        width: 19.59.w,
                                        color: Styles.DETAILS_COLOR
                                      )
                                    : customImageIconSVG(
                                        imageName: SvgImages.eyeIcon,
                                        height: 16.55.h,
                                        width: 19.59.w,
                                        color: Styles.PRIMARY_COLOR,
                                      ),
                              )
                            : null),
          ),
          enabledBorder: _borders.copyWith(
              borderSide: widget.addBorder
                  ? BorderSide(
                      color: widget.read == true
                          ? Styles.DISABLED
                          : Styles.BORDER_COLOR)
                  : null),
          disabledBorder: _borders.copyWith(
              borderSide: widget.addBorder
                  ? const BorderSide(color: Styles.BORDER_COLOR)
                  : null),
          focusedBorder: _borders.copyWith(
              borderSide: widget.addBorder
                  ? BorderSide(
                      color: widget.read == true
                          ? Styles.DISABLED
                          : Styles.PRIMARY_COLOR)
                  : null),
          errorBorder: _borders.copyWith(
              borderSide: widget.addBorder
                  ? const BorderSide(color: Styles.FAILED_COLOR)
                  : null),
          border: _borders.copyWith(
              borderSide: widget.addBorder
                  ? BorderSide(
                      color: widget.read == true
                          ? Styles.DISABLED
                          : Styles.BORDER_COLOR)
                  : null),
          contentPadding:
              EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
          isDense: true,
          alignLabelWithHint: true,
          hintText: widget.hint,
          labelStyle: AppTextStyles.regular
              .copyWith(color: Styles.DISABLED, fontSize: 14),
          hintStyle: AppTextStyles.regular
              .copyWith(color: Styles.DISABLED, fontSize: 12),
          labelText: widget.label ? widget.hint : null,
          fillColor: Styles.FILL_COLOR,
          floatingLabelStyle: AppTextStyles.regular
              .copyWith(color: Styles.TITLE, fontSize: 12),
          filled: true,
          errorStyle: AppTextStyles.regular.copyWith(
            color: Styles.FAILED_COLOR,
            fontSize: 11,
          ),
          errorMaxLines: 2,
          prefixIconConstraints:
              BoxConstraints(maxHeight: 25.h, maxWidth: 70.w),
          suffixIconConstraints: BoxConstraints(maxHeight: 25.h),
        ),
      ),
    );
  }
}
