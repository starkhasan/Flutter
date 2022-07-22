import 'package:flutter/material.dart';
import 'package:flutter_desktop/constants/app_colors.dart';
import 'package:flutter_desktop/controllers/dashboard_controller.dart';
import 'package:flutter_desktop/custom_widgets/custom_bottom_tab.dart';
import 'package:flutter_desktop/utils/helper.dart';
import 'package:get/get.dart';
import '../constants/strings.dart';

class DashboardScreen extends StatelessWidget {

  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context){
    final dashboardController = Get.put(DashboardController());
    return Container(
      color: AppColors.white,
      child: GetBuilder<DashboardController>(
        init: dashboardController,
        builder: (data) {
          return Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(color: AppColors.teal),
              ),
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    Container(
                      color: AppColors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomBottomTab(
                            tabs: Helper.dashboardTab, 
                            selectedTab: dashboardController.selectedTabIndex, 
                            onTabChange: (index) => dashboardController.onTabChange(index)
                          ),
                          Container(
                            width: Get.width * 0.20,
                            margin: const EdgeInsets.only(right: 15),
                            padding: const EdgeInsets.only(top: 5, bottom: 5, left: 8, right: 8),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.grey, width: 0.5),
                              borderRadius: const BorderRadius.all(Radius.circular(5.0))
                            ),
                            child: Row(
                              children: const [
                                Icon(Icons.search,size: 18, color: AppColors.grey),
                                SizedBox(width: 5.0),
                                Expanded(
                                  child: TextField(
                                    style: TextStyle(fontSize: 12),
                                    decoration: InputDecoration.collapsed(
                                      hintText: Strings.search,
                                      hintStyle: TextStyle(fontSize: 12)
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: AppColors.lightBlue
                      ),
                    )
                  ]
                )
              ),
            ],
          );
        }
      ),
    );
  }
}