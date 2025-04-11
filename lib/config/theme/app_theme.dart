import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

@immutable
class AppTheme {
  const AppTheme._();

  static final light = ThemeData(
    textTheme: TextTheme(
      // display
      displayLarge: GoogleFonts.roboto(
        fontSize: 39,
        fontWeight: FontWeight.bold,
        color: AppColors.activeColor,
      ),
      displayMedium: GoogleFonts.roboto(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: AppColors.activeColor,
      ),
      displaySmall: GoogleFonts.roboto(
        fontSize: 20,
        fontWeight: FontWeight.normal,
        color: AppColors.activeColor,
      ),

      // title
      titleLarge: GoogleFonts.roboto(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: AppColors.textMediumColor,
      ),
      titleMedium: GoogleFonts.roboto(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.withOpacityColor,
      ),
      titleSmall: GoogleFonts.roboto(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.activeColor,
      ),

      // label
      labelLarge: GoogleFonts.roboto(
        fontSize: 18,
        fontWeight: FontWeight.normal,
        color: AppColors.withOpacityColor,
      ),
      labelMedium: GoogleFonts.roboto(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: AppColors.backgroundColor,
      ),
      labelSmall: GoogleFonts.roboto(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: AppColors.blackColor,
      ),

      // body
      bodyLarge: GoogleFonts.roboto(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: AppColors.blackColor,
      ),
      bodyMedium: GoogleFonts.roboto(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppColors.blackColor,
      ),
      bodySmall: GoogleFonts.roboto(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: AppColors.blackColor,
      ),

      // headline
      headlineLarge: GoogleFonts.roboto(
        fontSize: 25,
        fontWeight: FontWeight.normal,
        color: AppColors.textMediumColor,
      ),
      headlineMedium: GoogleFonts.roboto(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: AppColors.textMediumColor,
      ),
    ),
  );
}

class AppColors {
  static const Color backgroundColor = Color.fromRGBO(255, 255, 255, 1.0);
  static const Color buttonColor = Color.fromRGBO(229, 229, 229, 1);
  static const Color withOpacityColor = Color.fromRGBO(0, 0, 0, 0.54);
  static const Color googleColor = Color.fromRGBO(215, 73, 55, 1.0);
  static const Color activeColor = Color.fromRGBO(29, 81, 163, 1.0);
  static const Color inActiveColor = Color.fromRGBO(229, 229, 229, 1.0);
  static const Color checkColor = Color.fromRGBO(253, 68, 95, 1.0);
  static const Color starColor = Color.fromRGBO(255, 223, 64, 1.0);
  static const Color blackColor = Color.fromRGBO(51, 51, 51, 1.0);
  static const Color greyColor = Color.fromRGBO(119, 119, 118, 1.0);
  static const Color textMediumColor = Color.fromRGBO(82, 82, 82, 1.0);
  static const Color withOpacityInActiveColor = Color.fromRGBO(0, 0, 0, 0.26);
}
