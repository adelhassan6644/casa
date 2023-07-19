import 'package:casa/app/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:casa/features/splash/provider/splash_provider.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/images.dart';
import '../../../navigation/custom_navigation.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    Provider.of<SplashProvider>(CustomNavigator.navigatorState.currentContext!,
            listen: false)
        .startTheApp();
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Styles.SPLASH_BACKGROUND_COLOR,
        body: Stack(
          alignment: Alignment.center,
          children: [
            Container(
                height: context.height,
                width: context.width,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    color: Styles.SPLASH_BACKGROUND_COLOR),
                child: const SizedBox()),
            Image.asset(
              Images.logo,
              width: context.width,
              height: 300,
            )
                .animate()
                .scale(duration: 1000.ms)
                .then(delay: 500.ms) // baseline=800ms
                .slide()
                .scaleXY(duration: 1000.ms)
                .then(delay: 200.ms)
                .shimmer(duration: 1000.ms),
          ],
        ));
  }
}
