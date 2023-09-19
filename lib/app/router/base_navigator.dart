import 'package:flutter/material.dart';

abstract class BaseNavigator {
  // Creation a singleton instance of the class
  BaseNavigator._();

  // Static function to get access to the Navigator key
  static final key = GlobalKey<NavigatorState>();

  /// Getting context to be able to use to access providers everywhere
  static BuildContext get currentContext => key.currentState!.context;

  ///Can pop navigation check
  static bool get canPop => key.currentState!.canPop();

  ///Push named navigation
  static Future<dynamic> pushNamed(String route, {args}) {
    return key.currentState!.pushNamed(
      route,
      arguments: args,
    );
  }

  ///Push named replacement navigation
  static Future<dynamic> pushNamedAndReplace(String route, {args}) {
    return key.currentState!.pushReplacementNamed(
      route,
      arguments: args,
    );
  }

  ///Push named and remove until replacement navigation
  static Future<dynamic> pushNamedAndclear(String route, {args}) {
    return key.currentState!.pushNamedAndRemoveUntil(
      route,
      (_) => false,
      arguments: args,
    );
  }

  ///First route navigation
  static firstRoute() {
    return key.currentState!.popUntil((route) => route.isFirst);
  }

  ///First route navigation
  static popUntilNav(bool Function(Route<dynamic>) check) {
    return key.currentState!.popUntil(check);
  }

  ///Pop replacement navigation
  static void pop([result]) {
    if (canPop) return key.currentState!.pop(result);
  }
}
