import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import 'custom_text.dart';

class CustomBottomTab extends StatelessWidget {
  final List<String> tabs;
  final int selectedTab;
  final ValueChanged<int> onTabChange;
  const CustomBottomTab({super.key, required this.tabs, required this.selectedTab, required this.onTabChange});

  @override
  Widget build(BuildContext context){
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        tabs.length, 
        (index) => InkWell(
          onTap: () => onTabChange(index),
          child: Container(
            margin: const EdgeInsets.only(left: 15),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: selectedTab == index 
                  ? AppColors.blue
                  : AppColors.transparent, 
                  width: 2.0
                )
              )
            ),
            child: Center(
              child: CustomText(
                title: tabs[index], 
                textSize: 12,
                textColor: selectedTab == index 
                ? AppColors.black
                : AppColors.grey
              )
            )
          ),
        ),
      )
    );
  }
}