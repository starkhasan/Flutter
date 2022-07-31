import 'package:flutter/material.dart';
import '../../utils/extension_method.dart';
import '../../constants/app_colors.dart';
import '../../constants/font_path.dart';
import '../../constants/image_path.dart';
import '../../controllers/dektop_dashboard_controller.dart';
import 'package:get/get.dart';

class DektopDashboardScreen extends StatelessWidget {
  const DektopDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    final dashboardController = Get.put(DesktopDashboardController());
    return Container(
      color: AppColors.white,
      child: Obx(() {
          return Stack(
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      left: Get.width * 0.025, 
                      right: Get.width * 0.025
                    ),
                    color: Colors.red
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      color: AppColors.white,
                      padding: EdgeInsets.only(left: Get.width * 0.025, right: Get.width * 0.025),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: Get.height * 0.08,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(20.0),
                                  height: Get.height * 0.42,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                    image: DecorationImage(image: AssetImage(ImagePath.sunny), fit: BoxFit.cover)
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: const [
                                          CircleAvatar(radius: 20.0,backgroundColor: AppColors.white),
                                          SizedBox(width: 10),
                                          Text(
                                            'Weather\nWhat is the weather',
                                          )
                                        ],
                                      ),
                                      Text(
                                        dashboardController.weatherResponse.main == null
                                        ? ''
                                        : dashboardController.weatherResponse.main!.feelsLike.convertToCelcius,
                                        style: const TextStyle(
                                          color: AppColors.black, 
                                          fontSize: 24, 
                                          fontWeight: FontWeight.bold, 
                                          fontFamily: FontPath.montserratSemiBole
                                        )
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              padding: const EdgeInsets.only(top: 8, bottom: 10),
                                              decoration: const BoxDecoration(
                                                color: AppColors.black,
                                                borderRadius: BorderRadius.all(Radius.circular(15.0))
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  const Text('Pressure', style: TextStyle(fontSize: 11.0, color: AppColors.white)),
                                                  const SizedBox(height: 5),
                                                  Text(
                                                    dashboardController.weatherResponse.main == null
                                                    ? ''
                                                    : dashboardController.weatherResponse.main!.pressure.toString(),
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: FontPath.montserratSemiBole,
                                                      color: AppColors.white
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Get.width * 0.02,
                                          ),
                                          Expanded(
                                            child: Container(
                                              padding: const EdgeInsets.only(top: 10, bottom: 10),
                                              decoration: const BoxDecoration(
                                                color: AppColors.black,
                                                borderRadius: BorderRadius.all(Radius.circular(15.0))
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  const Text('Visibility', style: TextStyle(fontSize: 11.0,color: AppColors.white)),
                                                  const SizedBox(height: 5),
                                                  Text(
                                                    dashboardController.weatherResponse.visibility == null
                                                    ? ''
                                                    : dashboardController.weatherResponse.visibility.toString(),
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: FontPath.montserratSemiBole,
                                                      color: AppColors.white
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Get.width * 0.02,
                                          ),
                                          Expanded(
                                            child: Container(
                                              padding: const EdgeInsets.only(top: 11, bottom: 10),
                                              decoration: const BoxDecoration(
                                                color: AppColors.black,
                                                borderRadius: BorderRadius.all(Radius.circular(15.0))
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  const Text('Humidity', style: TextStyle(fontSize: 12.0, color: AppColors.white)),
                                                  const SizedBox(height: 5),
                                                  Text(
                                                    dashboardController.weatherResponse.main == null
                                                    ? ''
                                                    : dashboardController.weatherResponse.main!.humidity.toString(),
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: FontPath.montserratSemiBole,
                                                      color: AppColors.white
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Get.width * 0.02,
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(18.0),
                                  height: Get.height * 0.42,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                    image: DecorationImage(image: AssetImage(ImagePath.cloud), fit: BoxFit.cover)
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: const [
                                          CircleAvatar(radius: 20.0,backgroundColor: AppColors.white),
                                          SizedBox(width: 10),
                                          Text(
                                            'Wind',
                                          ),
                                        ],
                                      ),
                                      const Text(
                                        '22 c',
                                        style: TextStyle(
                                          color: AppColors.white, 
                                          fontSize: 24, 
                                          fontWeight: FontWeight.bold, 
                                          fontFamily: FontPath.montserratSemiBole
                                        ),
                                      ),
                                    ],
                                  )
                                ),
                              )
                            ],
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: Get.width * 0.02,
                                bottom: Get.width * 0.02
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: AppColors.blue,
                                        borderRadius: BorderRadius.all(Radius.circular(20.0))
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.02,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      padding: const EdgeInsets.all(18.0),
                                      height: Get.height * 0.42,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                        image: DecorationImage(image: AssetImage(ImagePath.cloud), fit: BoxFit.cover)
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Text('Tomorrow'),
                                          Text('Alam Barzah'),
                                          Text(
                                            '22 c',
                                            style: TextStyle(
                                              color: AppColors.white, 
                                              fontSize: 24, 
                                              fontWeight: FontWeight.bold, 
                                              fontFamily: FontPath.montserratSemiBole
                                            ),
                                          ),
                                        ],
                                      )
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(color: AppColors.black)
                  ),
                ],
              ),
              Visibility(
                visible: dashboardController.isLoading.value,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
            ],
          );
        }
      ),
    );
  }
}