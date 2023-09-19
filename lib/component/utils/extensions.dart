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
  TextStyle get headline1 => Theme.of(this).extension<EventsTextTheme>()!.headline1!;
  TextStyle get headline2 => Theme.of(this).extension<EventsTextTheme>()!.headline2!;
  TextStyle get headline3 => Theme.of(this).extension<EventsTextTheme>()!.headline3!;
  TextStyle get button => Theme.of(this).extension<EventsTextTheme>()!.button!;
}
