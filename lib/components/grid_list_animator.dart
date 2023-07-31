import 'package:flutter/cupertino.dart';
import '../app/core/utils/dimensions.dart';

class GridListAnimatorWidget extends StatelessWidget {
  const GridListAnimatorWidget(
      {this.aspectRatio, required this.items,this.physics ,Key? key})
      : super(key: key);
  final List<Widget> items;
  final double? aspectRatio;
  final ScrollPhysics? physics;
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.only(top: 20.h),
      crossAxisCount: 2,
      physics: physics?? const BouncingScrollPhysics(),
      shrinkWrap: true,
      addAutomaticKeepAlives: true,
      mainAxisSpacing: 8.h,
      childAspectRatio: aspectRatio ?? 0.748,
      crossAxisSpacing: 8.w,
      children: items,
    );
  }
}
