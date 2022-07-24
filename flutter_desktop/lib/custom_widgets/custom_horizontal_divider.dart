import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class CustomHorizontalDivider extends StatelessWidget {
  final Color? color;
  final double? thickness;
  final double? height;
  const CustomHorizontalDivider({
    super.key,
    this.color,
    this.thickness,
    this.height
  });

  @override
  Widget build(BuildContext context){
    return Divider(
      color: color ?? AppColors.grey,
      thickness: thickness ?? 0.3,
      height: height ?? 0.3
    );
  }
}