// Extract the Repeated Tab Widget
import 'package:flutter/material.dart';
import 'package:track_distance/core/utils/size_config.dart';
import 'package:track_distance/core/values/app_colors.dart';


class TabButton extends StatelessWidget {
  final String text;
  const TabButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color:   AppColors.primaryColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: wi(25), vertical: he(5)),
        child: Text(
          text,
          style: TextStyle(
            color:  AppColors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}