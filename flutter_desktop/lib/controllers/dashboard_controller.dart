import 'package:flutter_desktop/constants/strings.dart';
import 'package:flutter_desktop/utils/helper.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController with Helper {

  int selectedTabIndex = 0;
  var daysReportDropdownList = Helper.emptyDaysReportDropDown;
  var selectedReport = Strings.zeroValue;
  var entryDropdownList = Helper.emptyEntriesDropDown;
  var selectedEntires = Strings.zeroValue;

  void onTabChange(int index){
    selectedTabIndex = index;
    update();
  }
}