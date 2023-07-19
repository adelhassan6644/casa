import 'package:casa/app/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../app/core/utils/styles.dart';
import '../app/localization/localization/language_constant.dart';

class PriceTextFormField extends StatelessWidget {
  final String? hint;
  final String? initialValue;
  final TextInputType? inputType;
  final void Function(String)? onChanged;
  final String? Function(String?)? validation;
  final List<TextInputFormatter>? formatter;
  final TextEditingController? controller;

  const PriceTextFormField({
    super.key,
    this.initialValue,
    this.validation,
    this.hint,
    this.onChanged,
    this.inputType,
    this.formatter,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      textAlign: TextAlign.center,
      controller: controller,
      minLines: 1,
      validator: validation,
      keyboardType: inputType,
      inputFormatters: inputType == TextInputType.phone
          ? [FilteringTextInputFormatter.allow(RegExp('[0-9]'))]
          : formatter,
      style: AppTextStyles.regular
          .copyWith(color: Styles.SECOUND_PRIMARY_COLOR, fontSize: 13),
      cursorColor: Styles.SECOUND_PRIMARY_COLOR,
      onChanged: onChanged,
      decoration: InputDecoration(
        suffixIconConstraints: const BoxConstraints(maxHeight: 22),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(top: 4, bottom: 4, left: 10),
          child: Text(
            getTranslated("sar", context),
            style: AppTextStyles.regular.copyWith(fontSize: 14, height: 1),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              6,
            ),
          ),
          borderSide: BorderSide(
              color: Colors.transparent, width: 0, style: BorderStyle.none),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              6,
            ),
          ),
          borderSide: BorderSide(
              color: Colors.transparent, width: 0, style: BorderStyle.none),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              6,
            ),
          ),
          borderSide: BorderSide(
              color: Colors.transparent, width: 0, style: BorderStyle.none),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        isDense: true,
        hintText: hint,
        fillColor: Styles.GREY_BORDER,
        filled: true,
      ),
    );
  }
}
