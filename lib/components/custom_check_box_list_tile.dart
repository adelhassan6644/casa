import 'package:flutter/material.dart';
import '../../app/core/utils/styles.dart';

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
        color: Styles.BORDER_COLOR,
        width: 9,
      ),
      controlAffinity: ListTileControlAffinity.leading,
      checkColor: Styles.WHITE_COLOR,
      contentPadding: EdgeInsets.zero,
      checkboxShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      activeColor: Styles.PRIMARY_COLOR,
      title: Text(
        title,
        style:   TextStyle(
            color:value ? Styles.PRIMARY_COLOR:Styles.HINT_COLOR,
            fontSize: 13,
            fontWeight: FontWeight.w700) ,
      ),
      subtitle:subTitle != null? Text(
        "(${subTitle??""})",
        style: value ? const TextStyle(
            color: Styles.PRIMARY_COLOR,
            fontSize: 11,
            fontWeight: FontWeight.w600)
            :  const TextStyle(
            color: Styles.HINT_COLOR,
            fontSize: 11,
            fontWeight: FontWeight.w600),
      ):null,
      value: value,
      onChanged: onChange,
    );
  }
}
