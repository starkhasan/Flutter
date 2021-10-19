import 'package:flutter/material.dart';
import 'package:test_app/networks/apis.dart';
import 'package:test_app/networks/response/fake_reponse.dart';
import 'dart:convert';

class RestAPI extends StatefulWidget {
  const RestAPI({Key? key}) : super(key: key);
  @override
  _RestAPIState createState() => _RestAPIState();
}

class _RestAPIState extends State<RestAPI> with Api {
  List<FakeResponse> response = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rest API')),
      floatingActionButton: FloatingActionButton(
        onPressed: callGetWithId,
        child: const Icon(Icons.api),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: response.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
          itemCount: response.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(color: Colors.grey, blurRadius: 1.0)
                ]
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('ID = ${response[index].id}'),
                  Text('Title : ${response[index].title}'),
                  Text('UserID : ${response[index].userId}'),
                  Text('Body: ${response[index].body}')
                ]
              ),
            );
          }
        )
      )
    );
  }

  // //calling get request for particular id
  // callApi() async{
  //   var response = await allPostWithId(1);
  //   //var fakeResponse = List<FakeResponse>.from(jsonDecode(response).map((x) => FakeResponse.fromJson(x)));
  //   setState(() {
  //     this.response = FakeResponse.fromJson(jsonDecode(response));
  //   });
  // }

  //calling
  callGetWithId() async {
    var response = await allPost();
    var fakeResponse = List<FakeResponse>.from(jsonDecode(response).map((x) => FakeResponse.fromJson(x)));
    setState(() {
      this.response = fakeResponse;
    });
  }

  /*
   *calling a post request to create a user
   *for post request we will send a user information in body of request
   *and a header in header
   */
  callPostCreateUser() async {
    Map<String, dynamic> body = {
      "firstName": "Ali",
      "lastName": "Hasan",
      "username": "alihasan226@gmail.com",
      "avatar":
          "https://www.gravatar.com/avatar/00000000000000000000000000000000",
      "email": "egestas.ultricies@mailinator.com",
      "age": 30,
      "gender": "M",
      "maritalStatus": "Single",
      "address": {
        "house": "A-23 Nec elit",
        "street": "Diam consectetur donec",
        "city": "Praesent",
        "zipcode": "78967",
        "country": "US",
        "geo": {"lat": "17.1234", "lng": "-876.9087"}
      },
      "phone": "(+1) 000 0000 000",
      "website": "example.com"
    };
    var response = await createUser(body);
    var tempResponse = jsonDecode(response);
    print('User created Successfully  =>  ID : ${tempResponse['id']}');
  }

  //Delete  a user using DELETE HTTP request after passing id in url
  callDeleteUser() async {
    var response = await deleteUser(1);
    var tempResponse = jsonDecode(response);
    print(tempResponse['success']);
  }

  //GET query parameter
  callQueryParam1() async {
    var tempResponse = await getQueryParam(1);
    print(tempResponse);
  }

  //Get query param Example 2
  callQueryParam2() async {
    var tempResponse = await getQueryParam2(30,40);
    print(tempResponse);
  }
}
