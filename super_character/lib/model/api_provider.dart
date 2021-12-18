import 'package:http/http.dart' as http;

class ApiProvider {

  static Future<String> superHero() async{
    try {
      var response = await http.get(Uri.parse('https://akabab.github.io/superhero-api/api/all.json'));
      if(response.statusCode == 200){
        return response.body;
      }else{
        return '400';
      }
    } catch (e) {
      return '400';
    }
  }

}