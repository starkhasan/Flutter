import 'package:flutter/material.dart';
import 'package:flutter_desktop/custom_widgets/custom_dropdown_button.dart';
import 'package:get/get.dart';
import '../constants/app_colors.dart';
import '../controllers/dashboard_controller.dart';
import '../custom_widgets/custom_bottom_tab.dart';
import '../custom_widgets/custom_horizontal_divider.dart';
import '../custom_widgets/custom_text.dart';
import '../utils/helper.dart';
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
                        padding: const EdgeInsets.all(15.0),
                        color: AppColors.lightBlue,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    CustomText(title: 'Follower Analytics', textColor: AppColors.black, fontWeight: FontWeight.bold),
                                    CustomText(title: "Here's your follower analytics for today", textColor: AppColors.grey, textSize: 10)
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(right: 8.0, top: 6.0, bottom: 6.0),
                                      decoration: const BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: BorderRadius.all(Radius.circular(10.0))
                                      ),
                                      child: CustomDropdownWidget(
                                        itemList: dashboardController.daysReportDropdownList, 
                                        initialValue: dashboardController.selectedReport, 
                                        onChanged: (value) => {
                                          dashboardController.selectedReport = value,
                                          dashboardController.update()
                                        }
                                      )
                                    ),
                                    const SizedBox(width: 10),
                                    Container(
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: const BoxDecoration(
                                        color: AppColors.blue,
                                        borderRadius: BorderRadius.all(Radius.circular(10.0))
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: const [
                                          Icon(Icons.download, color: AppColors.white, size: 18),
                                          SizedBox(width: 5),
                                          CustomText(title: 'Exports', textColor: AppColors.white, textSize: 12)
                                        ],
                                      )
                                    )
                                  ]
                                )
                              ], 
                            ),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                                decoration: const BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(10.0))
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const CustomText(title: 'Show ', textSize: 12, textColor: AppColors.grey),
                                              Container(
                                                padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
                                                decoration: BoxDecoration(
                                                  color: AppColors.white,
                                                  border: Border.all(color: AppColors.grey, width: 0.5),
                                                  borderRadius: const BorderRadius.all(Radius.circular(8.0))
                                                ),
                                                child: CustomDropdownWidget(
                                                  itemList: dashboardController.entryDropdownList,
                                                  initialValue: dashboardController.selectedEntires,
                                                  onChanged: (value) => {
                                                    dashboardController.selectedEntires = value,
                                                    dashboardController.update()
                                                  }
                                                )
                                              ),
                                              const CustomText(title: 'Entires', textSize: 12, textColor: AppColors.grey)
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    const CustomHorizontalDivider(),
                                    Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Row(
                                        children: const [
                                          Expanded(
                                            flex: 2,
                                            child: CustomText(title: 'Follower Name', textColor: AppColors.grey),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: CustomText(title: 'Email Address', textColor: AppColors.grey),
                                          ),
                                          Expanded(
                                            child: CustomText(title: 'Total Like', textColor: AppColors.grey),
                                          ),
                                          Expanded(
                                            child: CustomText(title: 'Total Comment', textColor: AppColors.grey),
                                          ),
                                          Expanded(
                                            child: CustomText(title: 'Followers ', textColor: AppColors.grey),
                                          ),
                                          Expanded(
                                            child: CustomText(title: 'Date Follow', textColor: AppColors.grey),
                                          )
                                        ]
                                      ),
                                    ),
                                    const CustomHorizontalDivider(),
                                    Expanded(
                                      child: ListView.separated(
                                        physics: const BouncingScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(left: 15, top: 8.0, bottom: 8.0, right: 15.0),
                                            child: Row(
                                              children: const [
                                                Expanded(
                                                  flex: 2,
                                                  child: CustomText(title: 'Follower Name'),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: CustomText(title: 'Email Address'),
                                                ),
                                                Expanded(
                                                  child: CustomText(title: 'Total Like'),
                                                ),
                                                Expanded(
                                                  child: CustomText(title: 'Total Comment'),
                                                ),
                                                Expanded(
                                                  child: CustomText(title: 'Followers '),
                                                ),
                                                Expanded(
                                                  child: CustomText(title: 'Date Follow'),
                                                )
                                              ]
                                            ),
                                          );
                                        }, 
                                        separatorBuilder: (context, index) => const CustomHorizontalDivider(), 
                                        itemCount: 50
                                      )
                                    )
                                  ]
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const CustomText(title: "Showing 1 to 10 of entries", textColor: AppColors.grey),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(left: 10, top: 8, bottom: 8,right: 10),
                                      decoration: const BoxDecoration(
                                        color: AppColors.blue,
                                        borderRadius: BorderRadius.all(Radius.circular(8.0))
                                      ),
                                      child: const CustomText(title: 'Previous', textColor: AppColors.white)
                                    ),
                                    const SizedBox(width: 10),
                                    Container(
                                      padding: const EdgeInsets.only(left: 10, top: 8, bottom: 8,right: 10),
                                      decoration: const BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: BorderRadius.all(Radius.circular(8.0))
                                      ),
                                      child: const CustomText(title: '1', textColor: AppColors.black)
                                    ),
                                    const SizedBox(width: 10),
                                    Container(
                                      padding: const EdgeInsets.only(left: 10, top: 8, bottom: 8,right: 10),
                                      decoration: const BoxDecoration(
                                        color: AppColors.blue,
                                        borderRadius: BorderRadius.all(Radius.circular(8.0))
                                      ),
                                      child: const CustomText(title: 'Next', textColor: AppColors.white)
                                    ),
                                  ]
                                )
                              ], 
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}