import 'package:http/http.dart' as http;

class Api {

  static Future<dynamic> getCountriesCases() async {
    Map<String, String> headers = {'Accept': 'application/json'};
    var uri =
        Uri.parse('https://coronavirus-19-api.herokuapp.com/countries/india');
    try {
      var response = await http.get(uri, headers: headers);
      return response;
    } catch (e) {
      return e;
    }
  }

  static Future<dynamic> countryCovidList() async {
    Map<String, String> headers = {'Accept': 'application/json'};
    var uri = Uri.parse('https://coronavirus-19-api.herokuapp.com/countries');
    try {
      var response = await http.get(uri, headers: headers);
      return response;
    } catch (e) {
      return e;
    }
  }
  
}
