import 'package:flutter/material.dart';

///
/// Created by Auro on 20/09/23 at 1:47 AM
///

mixin AppColors {
  static const brightBackground = Color(0xffFAFAFA);
  static const darkBackground = Color(0xff3e3e3e);
  static const borderColor = Color(0xffD9D9D9);
  static const brightSecondaryColor = Color(0xffF8CD5B);
  static const green = Color(0xff56AB18);
  static const divider = Color(0xffF1F1F1);
  static const darkGrey = Color(0xff676F75);
  static const grey = Color(0xff888888);
  static const brightTextColor = Color(0xff2D2D2D);
  static const dividerSlot = Color(0xffEAEAEA);
  static const blue = Color(0xff3582EC);
  static const desc = Color(0xffB1B1B1);
  static const primary = Color(0xffB1B1B1);
  static const labelColor = Color(0xff949494);
  static const descColor = Color(0xff727272);
  static const descColor_2 = Color(0xffA6A6A6);
  static const fillBgColor = Color(0xffF8FAFD);

  static const MaterialColor brightPrimary =
      MaterialColor(_brightPrimaryValue, <int, Color>{
    50: Color(0xFFFEF9EB),
    100: Color(0xFFFDF0CE),
    200: Color(0xFFFCE6AD),
    300: Color(0xFFFADC8C),
    400: Color(0xFFF9D574),
    500: Color(_brightPrimaryValue),
    600: Color(0xFFF7C853),
    700: Color(0xFFF6C149),
    800: Color(0xFFF5BA40),
    900: Color(0xFFF3AE2F),
  });
  static const int _brightPrimaryValue = 0xFFB069FF;

  static const MaterialColor darkPrimary =
      MaterialColor(_darkprimaryPrimaryValue, <int, Color>{
    50: Color(0xFFFFE1E9),
    100: Color(0xFFFFB5C7),
    200: Color(0xFFFF84A2),
    300: Color(0xFFFF527C),
    400: Color(0xFFFF2D60),
    500: Color(_darkprimaryPrimaryValue),
    600: Color(0xFFFF073E),
    700: Color(0xFFFF0635),
    800: Color(0xFFFF042D),
    900: Color(0xFFFF021F),
  });
  static const int _darkprimaryPrimaryValue = 0xFFFF0844;

  static const MaterialColor darkprimaryAccent =
      MaterialColor(_darkprimaryAccentValue, <int, Color>{
    100: Color(0xFFFFFFFF),
    200: Color(_darkprimaryAccentValue),
    400: Color(0xFFFFBFC4),
    700: Color(0xFFFFA6AC),
  });
  static const int _darkprimaryAccentValue = 0xFFFFF2F3;
}
