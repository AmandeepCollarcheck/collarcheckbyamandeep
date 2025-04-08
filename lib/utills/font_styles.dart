import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class AppTextStyles {
  static const String fontFamily = 'Urbanist';

  static const TextStyle regular = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    decorationThickness: 0.5,
    fontWeight: FontWeight.w400, // Regular
  );

  static const TextStyle bold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    decorationThickness: 0.5,
    fontWeight: FontWeight.w700, // Bold
  );

  static const TextStyle italic = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    decorationThickness: 0.5,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic, // Italic
  );

  static const TextStyle light = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    decorationThickness: 0.5,
    fontWeight: FontWeight.w300, // Light
  );

  static const TextStyle medium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    decorationThickness: 0.5,
    fontWeight: FontWeight.w500, // Medium
  );

  static const TextStyle semiBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    decorationThickness: 0.5,
    fontWeight: FontWeight.w600, // SemiBold
  );

  static const TextStyle extraBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    decorationThickness: 0.5,
    fontWeight: FontWeight.w800, // ExtraBold
  );

  static const TextStyle black = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    decorationThickness: 0.5,
    fontWeight: FontWeight.w900, // Black
  );
  static const TextStyle font20 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 22,
    decorationThickness: 0.5,
    fontWeight: FontWeight.w600, // SemiBold
  );
  static const TextStyle font22w700 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 22,
    decorationThickness: 0.5,
    fontWeight: FontWeight.w700, // SemiBold
  );
  static const TextStyle font28 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    decorationThickness: 0.5,
    fontWeight: FontWeight.w700, // SemiBold
  );
  static const TextStyle font14 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    decorationThickness: 0.5,
    fontWeight: FontWeight.w600, // SemiBold
  );
  static const TextStyle font16 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    decorationThickness: 0.5,
    fontWeight: FontWeight.w500, // SemiBold
  );
  static const TextStyle font16W600 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    decorationThickness: 0.5,
    fontWeight: FontWeight.w600, // SemiBold
  );
  static const TextStyle font16W600Underline = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    decorationThickness: 0.5,
    decoration: TextDecoration.underline,
    fontWeight: FontWeight.w600, // SemiBold
  );
  static const TextStyle font14Underline = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    decorationThickness: 0.5,
    decoration: TextDecoration.underline,
    fontWeight: FontWeight.w600, // SemiBold
  );
  static const TextStyle font12 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    decorationThickness: 0.5,
    fontWeight: FontWeight.w600, // SemiBold
  );
  static const TextStyle font18w700 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    decorationThickness: 0.5,
    fontWeight: FontWeight.w700, // SemiBold
  );

  static const TextStyle font12w500 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    decorationThickness: 0.5,
    fontWeight: FontWeight.w500, // SemiBold
  );
  static const TextStyle font10 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    decorationThickness: 0.5,
    fontWeight: FontWeight.w600, // SemiBold
  );
  static const TextStyle font14W500 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    decorationThickness: 0.5,
    fontWeight: FontWeight.w500, // SemiBold
  );
  static const TextStyle font14W700 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    decorationThickness: 0.5,
    fontWeight: FontWeight.w700, // SemiBold
  );
  static const TextStyle font16W700 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    decorationThickness: 0.5,
    fontWeight: FontWeight.w700, // SemiBold
  );
  static const TextStyle font20W700 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    decorationThickness: 0.5,
    fontWeight: FontWeight.w700, // SemiBold
  );
  static const TextStyle font20w600 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    decorationThickness: 0.5,
    fontWeight: FontWeight.w600, // SemiBold
  );
  static const TextStyle font20w500 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    decorationThickness: 0.5,
    fontWeight: FontWeight.w500, // SemiBold
  );
}






class AppTheme {
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    fontFamily: AppTextStyles.fontFamily,
    textTheme: TextTheme(
      bodyLarge: AppTextStyles.regular,
      bodyMedium: AppTextStyles.medium,
      bodySmall: AppTextStyles.light,
      titleLarge: AppTextStyles.bold,
      titleMedium: AppTextStyles.semiBold,
      titleSmall: AppTextStyles.extraBold,
    ),
  );

  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    fontFamily: AppTextStyles.fontFamily,
    textTheme: TextTheme(
      bodyLarge: AppTextStyles.regular,
      bodyMedium: AppTextStyles.medium,
      bodySmall: AppTextStyles.light,
      titleLarge: AppTextStyles.bold,
      titleMedium: AppTextStyles.semiBold,
      titleSmall: AppTextStyles.extraBold,
    ),
    brightness: Brightness.dark,
  );
}

