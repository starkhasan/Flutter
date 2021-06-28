import 'package:http/http.dart' as http;

class Api {
  static Future<String> globalSummary() async {
    Map<String, String> headers1 = {'Accept': 'application/json'};
    var uri = Uri.parse('https://api.covid19api.com/summary');
    try {
      var response = await http.get(uri, headers: headers1);
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
    var uri = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    try {
      var response = await http.get(uri, headers: headers1);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return "400";
      }
    } catch (e) {
      return "500";
    }
  }

  static Future<String> getUserProfile() async {
    Map<String, String> headers1 = {'Accept': 'application/json'};
    var uri = Uri.parse('https://jsonplaceholder.typicode.com/users');
    try {
      var response = await http.get(uri, headers: headers1);
      if (response.statusCode == 200)
        return response.body;
      else
        return '400';
    } catch (e) {
      return '500';
    }
  }

  static Future<dynamic> getCountries() async {
    Map<String, String> headers = {'Accept': 'application/json'};
    var uri = Uri.parse('https://api.covid19api.com/countries');
    try {
      var response = await http.get(uri, headers: headers);
      return response;
    } catch (e) {
      return e;
    }
  }

  static Future<dynamic> getCountriesCases(String country,String date) async {
    Map<String, String> headers = {'Accept': 'application/json'};
    var uri = Uri.parse('https://api.covid19api.com/country/$country?from=2020-01-30T00:00:00Z&to=$date');
    try {
      var response = await http.get(uri, headers: headers);
      return response;
    } catch (e) {
      return e;
    }
  }
}
