import 'package:flutter/material.dart';
import 'package:hurricane_events/component/theme/events_text_theme.dart';

/// This is a file for extension
/// Team members can create extensions as they see fit and use in every part of the app.
///
/// NOTE: When creation an extension, give a brief explanation of what your extension does.
///

/// An extension to shorten and stop boiler plate on theme extension declaration
extension TextTheming on BuildContext {
  TextStyle get body1 => Theme.of(this).extension<EventsTextTheme>()!.body1!;
  TextStyle get body2 => Theme.of(this).extension<EventsTextTheme>()!.body2!;
  TextStyle get body3 => Theme.of(this).extension<EventsTextTheme>()!.body3!;
  TextStyle get test => Theme.of(this).extension<EventsTextTheme>()!.testfield!;
  TextStyle get test2 => Theme.of(this).extension<EventsTextTheme>()!.testfield2!;
  TextStyle get headline1 => Theme.of(this).extension<EventsTextTheme>()!.headline1!;
  TextStyle get headline2 => Theme.of(this).extension<EventsTextTheme>()!.headline2!;
  TextStyle get headline3 => Theme.of(this).extension<EventsTextTheme>()!.headline3!;
  TextStyle get button1 => Theme.of(this).extension<EventsTextTheme>()!.button1!;
  TextStyle get button2 => Theme.of(this).extension<EventsTextTheme>()!.button2!;
}

extension LocalTime on DateTime {
  static final now = DateTime.now();
  static Duration offset = now.timeZoneOffset;
  static DateTime parse(String isoString) {
    DateTime time = DateTime.parse(isoString).add(offset);
    return time;
  }
}

extension Sizing on BuildContext {
  double get fullWidth => MediaQuery.of(this).size.width;
  double get fullHeight => MediaQuery.of(this).size.height;
}

//An extension to shorten spacing
/* Instead of SizedBox(height: 30), use 30.height, */
extension SizedBoxing on num {
  Widget get height {
    //To get MediQuery.of(context).size.height without context
    final height =
        WidgetsBinding.instance.platformDispatcher.views.first.physicalSize.height / WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;

    //Get the height in response to the design height
    ///This is to make your spacing relative to device height.
    final relativeHeight = (height / 926) * this;
    return SizedBox(
      height: relativeHeight,
    );
  }

  Widget get width {
    final width =
        WidgetsBinding.instance.platformDispatcher.views.first.physicalSize.width / WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;
    final relativeWidth = (width / 428) * this;
    return SizedBox(
      width: relativeWidth,
    );
  }
}
