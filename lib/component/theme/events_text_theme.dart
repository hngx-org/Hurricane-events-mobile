import 'package:flutter/material.dart';

/// This is a custom extension on theme
class EventsTextTheme extends ThemeExtension<EventsTextTheme> {
  final TextStyle? headline1;
  final TextStyle? headline2;
  final TextStyle? headline3;
  final TextStyle? body1;
  final TextStyle? body2;
  final TextStyle? body3;
  final TextStyle? button;

  const EventsTextTheme({
    this.headline1,
    this.headline2,
    this.headline3,
    this.body1,
    this.body2,
    this.body3,
    this.button,
  });

  /// This provides a fall back on every custom text theme (in this case) if not specified using the copyWith
  /// method
  const EventsTextTheme.fallback()
      : this(
          headline1: const TextStyle(
            fontWeight: FontWeight.w700,
            letterSpacing: 0,
          ),
          headline2: const TextStyle(
            fontWeight: FontWeight.w600,
            letterSpacing: 0,
          ),
          headline3: const TextStyle(
            fontWeight: FontWeight.w500,
            letterSpacing: 0,
          ),
          body1: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            letterSpacing: 0,
          ),
          body2: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            letterSpacing: 0,
          ),
          body3: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w300,
            letterSpacing: 0,
          ),
          button: const TextStyle(
            letterSpacing: 0,
            fontWeight: FontWeight.w600,
          ),
        );

  @override

  /// This method gives the opportunity to customise your selected text theme with a design choice of yours.
  EventsTextTheme copyWith({
    TextStyle? headline1,
    TextStyle? headline2,
    TextStyle? headline3,
    TextStyle? body1,
    TextStyle? body2,
    TextStyle? body3,
    TextStyle? button,
  }) {
    return EventsTextTheme(
      headline1: headline1 ?? this.headline1,
      headline2: headline2 ?? this.headline2,
      headline3: headline3 ?? this.headline3,
      body1: body1 ?? this.body1,
      body2: body2 ?? this.body2,
      body3: body3 ?? this.body3,
      button: button ?? this.button,
    );
  }

  @override

  /// This method provides a linear interpolation between two themes
  ThemeExtension<EventsTextTheme> lerp(covariant ThemeExtension<EventsTextTheme>? other, double t) {
    if (other is! EventsTextTheme) return this;

    return EventsTextTheme(
      headline1: TextStyle.lerp(headline1, other.headline1, t),
      headline2: TextStyle.lerp(headline2, other.headline2, t),
      headline3: TextStyle.lerp(headline3, other.headline3, t),
      body1: TextStyle.lerp(body1, other.body1, t),
      body2: TextStyle.lerp(body2, other.body2, t),
      body3: TextStyle.lerp(body3, other.body3, t),
      button: TextStyle.lerp(button, other.button, t),
    );
  }
}
