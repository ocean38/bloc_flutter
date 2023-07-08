import 'package:flutter/material.dart';
import 'package:impacteer/utils/app_colors.dart';

class AppStyles {
  /// FONT - FAMILY
  static String get fontFamily => 'SF-PRO';

  /// FONT - WEIGHT
  static FontWeight get semiBold => FontWeight.w600;
  static FontWeight get medium => FontWeight.w500;
  static FontWeight get bold => FontWeight.w700;
  static FontWeight get regular => FontWeight.w400;

  /// STYLE'S
  ///
  static TextStyle get black24SemiBold {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 24,
      color: AppColors.black,
      fontWeight: semiBold,
    );
  }

  static TextStyle get whiteBold {
    return TextStyle(color: Colors.white, fontWeight: bold);
  }

  static TextStyle get blackRegular {
    return TextStyle(color: AppColors.black, fontWeight: regular);
  }

  static TextStyle get white14 {
    return const TextStyle(color: Colors.white);
  }
}
