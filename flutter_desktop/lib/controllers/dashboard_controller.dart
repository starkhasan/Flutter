import 'package:get/get.dart';

class DashboardController extends GetxController {

  int selectedTabIndex = 0;

  void onTabChange(int index){
    selectedTabIndex = index;
    update();
  }
}