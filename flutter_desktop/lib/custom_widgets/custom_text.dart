import 'package:flutter/cupertino.dart';
import '../../constants/app_colors.dart';
import '../../constants/font_path.dart';

class CustomText extends StatelessWidget {
  final String title;
  final double? textSize;
  final Color? textColor;
  final String? fontFamily;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;

  const CustomText({
    super.key,
    required this.title,
    this.textSize,
    this.textColor,
    this.fontFamily,
    this.fontWeight,
    this.textAlign
  });

  @override
  Widget build(BuildContext context){
    return Text(
      title,
      style: TextStyle(
        fontSize: textSize ?? 14,
        color: textColor ?? AppColors.black,
        fontWeight: fontWeight ?? FontWeight.normal,
        fontFamily: fontFamily ?? FontPath.montserrat
      ),
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign ?? TextAlign.start,
    );
  }
}