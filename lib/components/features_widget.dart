import 'package:flutter/cupertino.dart';


class FeaturesWidget extends StatelessWidget {
  final Color bgColor;
  final Color iconColor;
  final String tipMassage;
  final String imagePath;

  const FeaturesWidget({Key? key, required this.bgColor, required this.iconColor, required this.tipMassage, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
              color: bgColor,
             shape: BoxShape.circle
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(imagePath,color:iconColor ,width: 30,),
            ],),

        ),
        SizedBox(
          width: 70,
          child: Text(
            tipMassage,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
