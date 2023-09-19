import 'package:flutter/material.dart';

class GlobalProvider extends ChangeNotifier {
  GlobalProvider._();
  static GlobalProvider instance = GlobalProvider._();
}
