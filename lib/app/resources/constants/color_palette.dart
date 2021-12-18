import 'package:flutter/material.dart';

class ColorPalette {
  static const MaterialColor lightPink =
      MaterialColor(_lightPinkPrimaryValue, <int, Color>{
    50: Color(0xFFFDEEED),
    100: Color(0xFFFAD5D1),
    200: Color(0xFFF7B9B3),
    300: Color(0xFFF39C95),
    400: Color(0xFFF1877E),
    500: Color(_lightPinkPrimaryValue),
    600: Color(0xFFEC6A5F),
    700: Color(0xFFE95F54),
    800: Color(0xFFE7554A),
    900: Color(0xFFE24239),
  });
  static const int _lightPinkPrimaryValue = 0xFFEE7267;

  static const MaterialColor lightPinkAccent =
      MaterialColor(_lightPinkAccentValue, <int, Color>{
    100: Color(0xFFFFFFFF),
    200: Color(_lightPinkAccentValue),
    400: Color(0xFFFFC9C6),
    700: Color(0xFFFFB1AD),
  });
  static const int _lightPinkAccentValue = 0xFFFFF9F9;

  static const MaterialColor deepOrange =
      MaterialColor(_deepOrangePrimaryValue, <int, Color>{
    50: Color(0xFFFEEAE6),
    100: Color(0xFFFCCBC1),
    200: Color(0xFFFAA898),
    300: Color(0xFFF8856E),
    400: Color(0xFFF76A4F),
    500: Color(_deepOrangePrimaryValue),
    600: Color(0xFFF4492B),
    700: Color(0xFFF24024),
    800: Color(0xFFF0371E),
    900: Color(0xFFEE2713),
  });
  static const int _deepOrangePrimaryValue = 0xFFF55030;

  static const MaterialColor deepOrangeAccent =
      MaterialColor(_deepOrangeAccentValue, <int, Color>{
    100: Color(0xFFFFFFFF),
    200: Color(_deepOrangeAccentValue),
    400: Color(0xFFFFBBB6),
    700: Color(0xFFFFA39C),
  });
  static const int _deepOrangeAccentValue = 0xFFFFEAE9;
}
