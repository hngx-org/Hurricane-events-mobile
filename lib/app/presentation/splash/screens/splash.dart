import 'package:flutter/material.dart';
import 'package:hurricane_events/app/router/base_navigator.dart';
import 'package:hurricane_events/component/constants/app_strings.dart';
import 'package:hurricane_events/component/constants/color.dart';
import 'package:hurricane_events/component/constants/images.dart';

import '../../timeline/screens/calendar_screen.dart';

class Splash extends StatefulWidget {
  static const String routeName = "splash-screen";
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    navigatetonextpage();
  }

  navigatetonextpage() async {
    await Future.delayed(const Duration(milliseconds: 2500), (() {}));
    BaseNavigator.pushNamedAndReplace(CalendarSection.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage(AppImages.imgSplashScreen)),
            SizedBox(
              height: 18,
            ),
            Text(
              AppStrings.SplashScreenText,
              style: TextStyle(
                  color: AppColors.darkBlue1,
                  fontSize: 32,
                  fontWeight: FontWeight.w700),
            )
          ],
        ),
      ),
    );
  }
}
