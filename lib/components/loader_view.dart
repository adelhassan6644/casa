import 'package:flutter/cupertino.dart';

class LoaderView extends StatelessWidget {
  const LoaderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: CupertinoActivityIndicator());
  }
}
