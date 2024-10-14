import 'package:flutter/material.dart';

class AppColors{
  static const Color backgroundColor = Color(0xFFF2F4F5);
  static const Color primaryColor = Color(0xFF1F8BFF);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const transparent = Colors.transparent;

  static const LinearGradient primaryLinearGradient = LinearGradient(
    colors: <Color>[
      white,
     primaryColor,
    ],
  );
}