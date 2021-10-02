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

  static Future<dynamic> worldVaccineCases() async{
    Map<String, String> headers = {'Accept': 'application/json'};
    var uri = Uri.parse('https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/vaccinations/vaccinations.json');
    try {
      var response = await http.get(uri,headers: headers);
      return response;
    } catch (e) {
      return e;
    }
  }
  
}
