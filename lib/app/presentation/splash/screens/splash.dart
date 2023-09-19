import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  static const String routeName = "splash-screen";
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
