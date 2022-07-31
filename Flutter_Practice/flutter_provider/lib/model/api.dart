import 'package:http/http.dart' as http;


class Api{

  static Future<dynamic> getComments() async{
    var response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/comments'));
    return response;
  }

}