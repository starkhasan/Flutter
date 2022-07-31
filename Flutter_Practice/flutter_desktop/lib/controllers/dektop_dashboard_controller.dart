import 'dart:convert';
import '../networks/api/api_client.dart';
import '../networks/end_points.dart';
import '../networks/response/weather_response.dart';
import 'package:get/get.dart';

class DesktopDashboardController extends GetxController {

  late ApiClient _apiClient;

  RxBool isLoading = false.obs;
  var weatherResponse = WeatherResponse();

  @override
  void onInit() {
    _apiClient = ApiClient();
    getWeatherReport();
    super.onInit();
  }


  Future<void> getWeatherReport() async {
    try {
      isLoading.value = true;
      var response = await _apiClient.getRequest(endPoint: EndPoints.baseUrl+'?q=arrah&appid='+EndPoints.openWeatherApiKey);
      weatherResponse = WeatherResponse.fromJson(jsonDecode(response.body));
      print(weatherResponse);
    } catch (e) {
      print('Something went wrong');
    } finally {
      isLoading.value = false;
    }
  }

}