import 'package:http/http.dart' as http;

class Api{
  
  static Future<String> globalSummary() async{
    Map<String, String> headers1 = {'Accept': 'application/json'};
    try{
      var response = await http.get('https://api.covid19api.com/summary',headers: headers1);
      return response.body;
    }catch(e){
      return 'Something went wrong';
    }
  }

}