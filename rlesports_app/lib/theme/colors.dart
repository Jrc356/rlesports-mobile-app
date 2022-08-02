import 'package:flutter/material.dart';

class AppColors {
  static const white = Color(0xffF0F0F0);
  static const outlines = Color(0xffDEDEDE);

  static const whiteGradient_1 = Color(0xffF5F5F5);
  static const whiteGradient_2 = Color(0xffB3B3B3);
  static const whiteGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      whiteGradient_1,
      whiteGradient_2,
    ],
  );

  static const grayGradient_1 = Color(0xffB3B3B3);
  static const grayGradient_2 = Color.fromARGB(255, 70, 70, 70);
  static const grayGradent = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      grayGradient_1,
      grayGradient_2,
    ],
  );

  static const navBarActiveIconFill = Color(0xffF5F5F5);
  static const navBarActiveIconBorder = Color(0xff666666);
  static const navBarInactiveIconFill = Color(0xff2A2A2A);
  static const navBarInactiveIconBorder = Color(0xffF0F0F0);

  static const rlOrange = Color(0xffFFAA00);
  static const rlBlue = Color(0xff005AFF);

  static const matteGrey = Color(0xff2A2A2A);
}
