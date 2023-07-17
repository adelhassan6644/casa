import 'package:flutter/material.dart';
import '../../app/core/utils/color_resources.dart';

class CustomCheckBoxListTile extends StatelessWidget {
  final String title;
  final String? subTitle;
  final bool value;
   final void Function(bool?) onChange;
  const CustomCheckBoxListTile(
      {required this.title,
         this.subTitle,
        required this.value,required this.onChange, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      side:  const BorderSide(
        color: ColorResources.BORDER_COLOR,
        width: 9,
      ),
      controlAffinity: ListTileControlAffinity.leading,
      checkColor: ColorResources.WHITE_COLOR,
      contentPadding: EdgeInsets.zero,
      checkboxShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      activeColor: ColorResources.PRIMARY_COLOR,
      title: Text(
        title,
        style:   TextStyle(
            color:value ? ColorResources.PRIMARY_COLOR:ColorResources.HINT_COLOR,
            fontSize: 13,
            fontWeight: FontWeight.w700) ,
      ),
      subtitle:subTitle != null? Text(
        "(${subTitle??""})",
        style: value ? const TextStyle(
            color: ColorResources.PRIMARY_COLOR,
            fontSize: 11,
            fontWeight: FontWeight.w600)
            :  const TextStyle(
            color: ColorResources.HINT_COLOR,
            fontSize: 11,
            fontWeight: FontWeight.w600),
      ):null,
      value: value,
      onChanged: onChange,
    );
  }
}
