import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

final appTheme = ThemeData(
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.scaffoldColor,
  textTheme: GoogleFonts.robotoTextTheme(ThemeData.light().textTheme).copyWith(
    displayLarge: TextStyle(
      fontSize: 32.sp,
      color: AppColors.textColor,
      fontWeight: FontWeight.w600,
    ),
    displayMedium: TextStyle(
        fontSize: 28.sp,
        color: AppColors.textColor,
        fontWeight: FontWeight.w600),
    displaySmall: TextStyle(fontSize: 24.sp, color: AppColors.textColor),
    bodyLarge: TextStyle(fontSize: 18.sp, color: AppColors.textColor),
    bodyMedium: TextStyle(fontSize: 16.sp, color: AppColors.textColor),
    titleMedium:
        TextStyle(color: AppColors.secondaryTextColor, fontSize: 15.sp),
    titleSmall: TextStyle(color: AppColors.secondaryTextColor, fontSize: 13.sp),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: AppColors.secondary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(15.sp),
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 6.0,
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      minimumSize: Size.fromHeight(50.sp),
      textStyle: TextStyle(
          fontSize: 16.sp,
          color: AppColors.textColor,
          fontWeight: FontWeight.w500),
      padding: EdgeInsets.symmetric(vertical: 15.sp, horizontal: 30.sp),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15.sp),
        ),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: const Color(0xFFe7e4fb),
    filled: true,
    labelStyle: TextStyle(color: AppColors.secondaryTextColor, fontSize: 16.sp),
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: AppColors.scaffoldColor),
    ),
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: AppColors.scaffoldColor),
    ),
  ),
  appBarTheme: AppBarTheme(
    foregroundColor: AppColors.textColor,
    elevation: 0,
    backgroundColor: AppColors.scaffoldColor,
    titleTextStyle: TextStyle(
        fontSize: 20.sp,
        color: AppColors.textColor,
        fontWeight: FontWeight.bold),
    centerTitle: true,
  ),
);
