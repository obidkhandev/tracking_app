import 'package:flutter/material.dart';
import 'package:track_distance/core/utils/size_config.dart';
import 'package:track_distance/core/values/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    this.radius,
    this.bgColor,
    this.textColor,
    this.paddingV,
    this.fontSize,
    this.borderColor,
    this.fontW,
    this.height,
  });

  final String text;
  final Function() onTap;
  final BorderRadius? radius;
  final double? paddingV;
  final double? fontSize;
  final FontWeight? fontW;

  final Color? bgColor;

  final Color? borderColor;
  final Color? textColor;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.transparent,
      borderRadius: radius ?? BorderRadius.circular(5),
      child: InkWell(
        splashColor: AppColors.transparent,
        // highlightColor: AppColors.transparent,
        hoverColor: AppColors.transparent,
        borderRadius: radius ?? BorderRadius.circular(5),
        onTap: onTap,
        child: Ink(
          height: height ?? he(50),
          padding: EdgeInsets.symmetric(
              vertical:  paddingV ?? he(5),
              horizontal: wi(8)),
          decoration: BoxDecoration(
              borderRadius: radius ?? BorderRadius.circular(5),
              border: Border.all(color: borderColor ?? AppColors.transparent),
              color: bgColor ?? AppColors.primaryColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                text,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: textColor ?? AppColors.white,
                      fontSize: fontSize ?? 16,
                      fontWeight: fontW,
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
