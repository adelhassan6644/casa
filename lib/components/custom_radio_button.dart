import 'package:casa/app/core/utils/dimensions.dart';
import 'package:flutter/material.dart';

import '../app/core/utils/styles.dart';

class CustomRadioButton extends StatefulWidget {
  final void Function(bool)? onChange;
  final bool check;
  final String title;

  const CustomRadioButton(
      {super.key, required this.check,
      this.onChange, required this.title});
  @override
  State<CustomRadioButton> createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
            onTap: () {
              if (widget.onChange != null) widget.onChange!(!widget.check);
            },
            child: widget.check ? Container(
                padding: const EdgeInsets.all(3),
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                    color: Styles.WHITE_COLOR,
                    shape: BoxShape.circle,
                    border: Border.all(color: Styles.PRIMARY_COLOR, width: 1)),
            child: Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Styles.PRIMARY_COLOR,),
            ),) : Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Styles.PRIMARY_COLOR, width: 1)),
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Styles.WHITE_COLOR,),
              ),
            ),),
        SizedBox(width: 8.w,),
        Expanded(
          child: Text(
           widget.title,
            style:TextStyle(
              fontSize: 14,
              overflow: TextOverflow.ellipsis,
              fontWeight:widget.check? FontWeight.w400:FontWeight.w600,
              color: widget.check? Styles.WHITE_COLOR:Styles.HINT_COLOR,
            ),
          ),
        ),
      ],
    );
  }
}

