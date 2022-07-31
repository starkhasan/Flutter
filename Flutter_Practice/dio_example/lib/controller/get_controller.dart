import 'package:dio_example/api/api_client.dart';
import 'package:dio_example/model/post_response.dart';
import 'package:get/get.dart';

class GetController extends GetxController {

  RxList<PostResponse> listPost = <PostResponse>[].obs;
  late ApiClient _apiClient;

  @override
  void onInit() {
    _apiClient = ApiClient();
    _apiClient.init();
    fetchPost();
    super.onInit();
  }

  void fetchPost() async {
    var response = await _apiClient.getRequest();
    listPost.value = List<PostResponse>.from((response.data as List).map((item) => PostResponse.fromJson(item)));
    update();
  }
}
