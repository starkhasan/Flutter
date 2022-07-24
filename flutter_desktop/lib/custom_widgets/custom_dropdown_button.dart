import 'package:flutter/material.dart';
import 'package:flutter_desktop/custom_widgets/custom_horizontal_divider.dart';
import '../constants/app_colors.dart';
import '../constants/font_path.dart';

class CustomDropdownWidget extends StatelessWidget {
  final String initialValue;
  final List<Map> itemList;
  final ValueChanged<dynamic> onChanged;
  const CustomDropdownWidget({
    super.key,
    required this.itemList,
    required this.initialValue,
    required this.onChanged
  });

  @override
  Widget build(BuildContext context){
    return ButtonTheme(
      alignedDropdown: true,
      child: DropdownButton(
        underline: const CustomHorizontalDivider(color: AppColors.transparent),
        value: initialValue,
        focusColor: AppColors. transparent,
        isDense: true,
        isExpanded: false,
        iconSize: 18,
        icon: const Padding(padding: EdgeInsets.only(left: 5.0), child: Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.grey, size: 18)),
        style: const TextStyle(
          fontSize: 12,
          color: AppColors.black,
          fontFamily: FontPath.montserrat
        ),
        items: itemList.map((value) {
          return DropdownMenuItem(value: value['id'] , child: Text('${value['value']}'));
        }).toList(),
        onChanged: onChanged
      ),
    );
  }
}