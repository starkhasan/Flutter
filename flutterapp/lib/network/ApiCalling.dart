import 'dart:convert';
import 'package:flutterapp/network/response/UserResponse.dart';
import 'package:flutterapp/constant/Cv.dart';
import 'package:flutterapp/utils/Preferences.dart';
import 'package:http/http.dart' as http;


class ApiService{  

  static Future<List<dynamic>> login() async {
    final response = await http.get('${Cv.BASE_URL}/posts');
    var logindata;
    if(response.statusCode == 200){
      logindata = json.decode(response.body);
    }
    return logindata;
  }

  static Future<List<UserResponse>> user() async {
      final response = await http.get(Cv.BASE_URL_USER);
      if (response.statusCode == 200) {
          return List<UserResponse>.from(json.decode(response.body).map((x) => UserResponse.fromJson(x)));
      }else{
        throw Exception('Failed to load post');
      }
    }
  
    static Future<String> signin(Map user) async {
      var endPoints = "users/sign_in";
      Map<String,String> headers1 = {'Content-Type':'application/json','Accept':'application/vnd.folloh.v1'};
      var body1 = json.encode(user);
      var response = await http.post(Cv.URL_NATURALLY+endPoints,body:body1,headers: headers1);
      if (response.statusCode == 200) {
        return response.body;
      }else{
        return Cv.TIMEOUT;
      }
    }

    static Future<String> register(Map user) async{
      var endpoints = "users";
      Map<String,String> headers1 = {'Content-Type':'application/json','Accept':'application/vnd.folloh.v1','Authorization':''};
      var body1 = json.encode(user);
      var response = await http.post(Cv.URL_NATURALLY+endpoints,body: body1,headers: headers1);
      if(response.statusCode == 200){
        return response.body;
      }else{
        return Cv.TIMEOUT;
      }
    }

    static Future<String> forgetPassword(Map user) async{
      var token = await Preferences.getToken();
      var endpoints = "users/forget_password";
      Map<String,String> headers1 = {'Content-Type':'application/json','Accept':'application/vnd.folloh.v1','Authorization':'$token'};
      var body1 = json.encode(user);
      var response = await http.post(Cv.URL_NATURALLY+endpoints,body: body1,headers: headers1);
      if(response.statusCode == 200){
        return response.body;
      }else{
        return Cv.TIMEOUT;
      }
    }

    static Future<String> verifyOTP(Map user) async{
      var token = await Preferences.getToken();
      var endpoints = "users/verify_otp";
      Map<String,String> headers1 = {'Content-Type':'application/json','Accept':'application/vnd.folloh.v1','Authorization':'$token'};
      var body1 = json.encode(user);
      var response = await http.post(Cv.URL_NATURALLY+endpoints,body: body1,headers: headers1);
      if(response.statusCode == 200){
        return response.body;
      }else{
        return Cv.TIMEOUT;
      }
    }

    static Future<String> resendOTP(Map user) async{
      var token = await Preferences.getToken();
      var endpoints = "users/resend_otp";
      Map<String,String> headers1 = {'Content-Type':'application/json','Accept':'application/vnd.folloh.v1','Authorization':'$token'};
      var body1 = json.encode(user);
      var response = await http.post(Cv.URL_NATURALLY+endpoints,body: body1,headers: headers1);
      if(response.statusCode == 200){
        return response.body;
      }else{
        return Cv.TIMEOUT;
      }
    }

    static Future<String> updateProfile(Map user) async{
      var token = await Preferences.getToken();
      var endpoints = "users/update_profile";
      Map<String,String> headers1 = {'Content-Type':'application/json','Accept':'application/vnd.folloh.v1','Authorization':'$token'};
      var body1 = json.encode(user);
      var response = await http.post(Cv.URL_NATURALLY+endpoints,body: body1,headers: headers1);
      if(response.statusCode == 200){
        return response.body;
      }else{
        return Cv.TIMEOUT;
      }
    }

    static Future<String> addUserProfile(Map user) async{
      var token = await Preferences.getToken();
      var endpoints = "users/update_profile";
      Map<String,String> headers1 = {'Content-Type':'application/json','Accept':'application/vnd.folloh.v1','Authorization':'$token'};
      var body1 = json.encode(user);
      var response = await http.patch(Cv.URL_NATURALLY+endpoints,body: body1,headers: headers1);
      if(response.statusCode == 200){
        return response.body;
      }else{
        return Cv.TIMEOUT;
      }
    }

    static Future<String> addPets(Map user) async{
      var token = await Preferences.getToken();
      var endpoints = "temporary_pets";
      Map<String,String> headers1 = {'Content-Type':'application/json','Accept':'application/vnd.folloh.v1','Authorization':'$token'};
      var body1 = json.encode(user);
      var response = await http.post(Cv.URL_NATURALLY+endpoints,body: body1,headers: headers1);
      if(response.statusCode == 200){
        return response.body;
      }else{
        return Cv.TIMEOUT;
      }
    }

    static Future<String> getPets() async{
      var token = await Preferences.getToken();
      var endpoints = "pets";
      Map<String,String> headers1 = {'Content-Type':'application/json','Accept':'application/vnd.folloh.v1','Authorization':'$token'};
      var response = await http.get(Cv.URL_NATURALLY+endpoints,headers: headers1);
      if(response.statusCode == 200){
        return response.body;
      }else{
        return Cv.TIMEOUT;
      }
    }

    static Future<String> petUpdate(Map user,String id) async{
      var token = await Preferences.getToken();
      var endpoints = "pets/$id";
      var body1 = json.encode(user);
      Map<String,String> headers1 = {'Content-Type':'application/json','Accept':'application/vnd.folloh.v1','Authorization':'$token'};
      var response = await http.patch(Cv.URL_NATURALLY+endpoints,body:body1,headers: headers1);
      if(response.statusCode == 200){
        return response.body;
      }else{
        return Cv.TIMEOUT;
      }
    }

    static Future<String> getLocation() async{
      var endpoints = "devices/get_location";
      var token = await Preferences.getToken();
      Map<String,String> headers1 = {'Content-Type':'application/json','Accept':'application/vnd.folloh.v1','Authorization':'$token'};
      var response = await http.get(Cv.URL_NATURALLY+endpoints,headers: headers1);
      if(response.statusCode == 200){
        return response.body;
      }else{
        return Cv.TIMEOUT;
      }
    }

    static Future<String> getGeofence() async{
      var endpoints = "geofances";
      var token = await Preferences.getToken();
      Map<String,String> headers1 = {'Content-Type':'application/json','Accept':'application/vnd.folloh.v1','Authorization':'$token'};
      var response = await http.get(Cv.URL_NATURALLY+endpoints,headers: headers1);
      if(response.statusCode == 200){
        return response.body;
      }else{
        return Cv.TIMEOUT;
      }
    }

    static Future<String> getAllLocation(Map user) async{
      var endpoints = "devices/get_all_locations";
      var token = await Preferences.getToken();
      var body1 = json.encode(user);
      Map<String,String> headers1 = {'Content-Type':'application/json','Accept':'application/vnd.folloh.v1','Authorization':'$token'};
      var response = await http.post(Cv.URL_NATURALLY+endpoints,body:body1,headers: headers1);
      if(response.statusCode == 200){
        return response.body;
      }else{
        return Cv.TIMEOUT;
      }

    }
    
}
  
 