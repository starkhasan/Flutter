import 'package:http/http.dart' as http;

class Api {
  static Future<String> globalSummary() async {
    Map<String, String> headers1 = {'Accept': 'application/json'};
    try {
      var response = await http.get('https://api.covid19api.com/summary',
          headers: headers1);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return 'Service Temporarily Unavailable';
      }
    } catch (e) {
      return 'Something went wrong';
    }
  }

  static Future<String> getUser() async {
    Map<String, String> headers1 = {'Accept': 'application/json'};
    try{
      var response = await http.get('https://jsonplaceholder.typicode.com/posts',headers: headers1);
      if(response.statusCode == 200){
        return  response.body;
      }else{
        return "400";
      }
    }catch(e){
      return "500";
    }
  }
}
