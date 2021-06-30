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

  static Future<dynamic> worldPopulation(String country) async {
    Map<String, String> queries = {
      'country_name':country
    };
    Map<String, String> headers = {
      'Accept': 'application/json',
      "x-rapidapi-key": "3d54eaa871msh2d93a484635551cp1a4debjsn898d6d43af4c",
      "x-rapidapi-host": "world-population.p.rapidapi.com"
    };
    String queryString = Uri(queryParameters: queries).query;
    var url = Uri.parse("https://world-population.p.rapidapi.com/population?"+queryString);
    try {
      var response = await http.get(url,headers: headers);
      return response;
    } catch (e) {
      print(e);
    }
  }
  
}
