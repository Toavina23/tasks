import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

final appTheme = ThemeData(
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.scaffoldColor,
  textTheme: ThemeData.light().textTheme.copyWith(
        headline1: TextStyle(
            fontSize: 32.sp,
            color: AppColors.textColor,
            fontWeight: FontWeight.w600),
        headline2: TextStyle(
            fontSize: 28.sp,
            color: AppColors.textColor,
            fontWeight: FontWeight.w600),
        headline3: TextStyle(fontSize: 24.sp, color: AppColors.textColor),
        bodyText1: TextStyle(fontSize: 18.sp, color: AppColors.textColor),
        bodyText2: TextStyle(fontSize: 16.sp, color: AppColors.textColor),
        subtitle1:
            TextStyle(color: AppColors.secondaryTextColor, fontSize: 18.sp),
        subtitle2:
            TextStyle(color: AppColors.secondaryTextColor, fontSize: 16.sp),
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
      foregroundColor: AppColors.textColor,
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
    fillColor: AppColors.scaffoldColor,
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
      backgroundColor: AppColors.scaffoldColor,
      titleTextStyle: TextStyle(fontSize: 24.sp, color: AppColors.textColor),
      centerTitle: true),
);
