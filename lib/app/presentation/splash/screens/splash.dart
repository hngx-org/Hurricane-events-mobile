import 'package:flutter/material.dart';
import 'package:hurricane_events/app/presentation/home/home.dart';
import 'package:hurricane_events/app/router/base_navigator.dart';
import 'package:hurricane_events/component/constants/app_strings.dart';
import 'package:hurricane_events/component/constants/color.dart';
import 'package:hurricane_events/component/constants/images.dart';

class Splash extends StatefulWidget {
  static const String routeName = "splash-screen";
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  late Animation<double> _heightAnimation;
  late Animation<double> _widthAnimation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _widthAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(tween: Tween<double>(begin: 0, end: 250), weight: 200),
      TweenSequenceItem<double>(tween: Tween<double>(begin: 250, end: 200), weight: 200),
      TweenSequenceItem<double>(tween: Tween<double>(begin: 200, end: 220), weight: 200),
      TweenSequenceItem<double>(tween: Tween<double>(begin: 220, end: 250), weight: 200),
    ]).animate(_controller);
    _heightAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(tween: Tween<double>(begin: 0, end: 100), weight: 200),
      TweenSequenceItem<double>(tween: Tween<double>(begin: 100, end: 60), weight: 200),
      TweenSequenceItem<double>(tween: Tween<double>(begin: 60, end: 80), weight: 200),
      TweenSequenceItem<double>(tween: Tween<double>(begin: 80, end: 60), weight: 200),
    ]).animate(_controller);
    _controller.forward();
    navigatetonextpage();
  }

  navigatetonextpage() async {
    await Future.delayed(const Duration(milliseconds: 2000), (() {}));
    BaseNavigator.pushNamedAndReplace(HomeScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, _) {
                return SizedBox(
                  height: _heightAnimation.value,
                  width: _widthAnimation.value,
                  child: Image.asset(
                    AppImages.imgSplashScreen,
                    height: 300,
                    width: 300,
                  ),
                );
              },
            ),
            const SizedBox(
              height: 18,
            ),
            const Text(
              AppStrings.SplashScreenText,
              style: TextStyle(
                color: AppColors.darkBlue1,
                fontSize: 32,
                fontWeight: FontWeight.w700,
              ),
            )
          ],
        ),
      ),
    );
  }
}
