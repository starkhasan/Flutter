import 'dart:io';
import 'dart:convert';
import "package:http/http.dart" as http;

class Api {
  Future<String> allPostWithId(int id) async {
    try {
      var url = Uri.parse('https://jsonplaceholder.typicode.com/posts/$id');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return "";
      }
    } on SocketException catch (e) {
      return e.message;
    }
  }

  Future<String> allPost() async {
    try {
      var url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return "";
      }
    } on SocketException catch (e) {
      return e.message;
    }
  }

  Future<String> allPostRequest() async {
    try {
      var url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');
      var response = await http.post(url);
      return response.body;
    } catch (e) {
      return 'Could not found the result';
    }
  }

  Future<String> createUser(Map<String, dynamic> body) async {
    try {
      var url = Uri.parse('https://jsonplaceholder.typicode.com/users');
      Map<String, String> header = {'Accept': 'application/pdf'};
      var response =
          await http.post(url, body: jsonEncode(body), headers: header);
      if (response.statusCode == 201) {
        return response.body;
      } else {
        return '';
      }
    } on SocketException catch (e) {
      return e.message;
    }
  }

  Future<String> deleteUser(int id) async {
    try {
      Map<String, String> header = {'Content-type': 'application/json'};
      var url = Uri.parse('http://fakeapi.jsonparseronline.com/posts/$id');
      var response = await http.delete(url, headers: header);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return 'Something went wrong';
      }
    } on SocketException catch (e) {
      return e.message;
    }
  }

  Future<String> getQueryParam(int postId) async {
    Map<String, String> queryParam = {'postId': postId.toString()};
    Map<String, String> header = {'Accept': 'application/json'};
    var url = Uri.http('jsonplaceholder.typicode.com', 'comments', queryParam);
    try {
      var response = await http.get(url, headers: header);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return 'Something went wrong';
      }
    } on SocketException catch (e) {
      return e.message;
    }
  }

  Future<String> getQueryParam2(int gte, int lte) async {
    Map<String, String> queryParam = {
      'age_gte': gte.toString(),
      'age_lte': lte.toString()
    };
    Map<String, String> header = {'Accept': 'application/json'};
    var url = Uri.http('fakeapi.jsonparseronline.com', 'users', queryParam);
    try {
      var response = await http.get(url, headers: header);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return 'Something went wrong';
      }
    } on SocketException catch (e) {
      return e.message;
    }
  }
}
