
import 'package:flutter/material.dart';
import 'package:money/core/utils/app_colors.dart';

ThemeData appTheme()
{
  return ThemeData(
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(
        color: Colors.white
      ),
      backgroundColor: AppColors.primaryColor1,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20
      ),
      centerTitle: true
    ),
  );
}