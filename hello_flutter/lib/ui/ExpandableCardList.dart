import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/network/Api.dart';
import 'package:hello_flutter/utils/LanguageSettings/Languages.dart';
import 'package:hello_flutter/network/response/ProfileResonse.dart';

class ExpandableCardList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ExpandableCardList();
}

class _ExpandableCardList extends State<ExpandableCardList> with TickerProviderStateMixin{
  final items = List.generate(10, (i) => "Item ${i + 1}");
  var selected = 0;
  AnimationController animationController;

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(duration: new Duration(seconds: 2), vsync: this);
    animationController.repeat();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Languages.of(context).expandableTitle),
          centerTitle: true,
        ),
        body: Container(
          child: FutureBuilder(
          future: getUserProfile(),
          builder: (context, snapshot) {
            if (ConnectionState.done == snapshot.connectionState) {
              if (snapshot.data == '400' || snapshot.data == '500') {
                return Container(
                  child: Center(
                    child: Text("Sorry couldn't find the user"),
                  )
                );
              } else {
                var response = List<ProfileResonse>.from(json.decode(snapshot.data).map((x) => ProfileResonse.fromJson(x)));
                return ListView.builder(
                  itemCount: response.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ExpansionTile(
                        initiallyExpanded: selected == index,
                        onExpansionChanged: (value) {
                          selected  = index;
                        },
                        leading: Icon(Icons.account_circle,color:Colors.pink),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(response[index].name,style: TextStyle(fontFamily: 'PoppinsBlackMedium')),
                            SizedBox(height: 2),
                            Text(response[index].email,style: TextStyle(color: Colors.grey,fontSize: 12,fontFamily: 'PoppinsBlackMedium')),
                          ]
                        ),
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('UserName',style: TextStyle(color: Colors.grey,fontSize: 12)),
                                    Text(response[index].username,style: TextStyle(fontSize: 12))
                                  ]
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Phone',style: TextStyle(color: Colors.grey,fontSize: 12)),
                                    Text(response[index].phone,style: TextStyle(fontSize: 12))
                                  ]
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('WebSite',style: TextStyle(color: Colors.grey,fontSize: 12)),
                                    Text(response[index].website,style: TextStyle(fontSize: 12))
                                  ]
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Company',style: TextStyle(color: Colors.grey,fontSize: 12)),
                                    Text(response[index].company.name,style: TextStyle(fontSize: 12))
                                  ]
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Address',style: TextStyle(color: Colors.grey,fontSize: 12)),
                                    Text(
                                      response[index].address.street+', '+response[index].address.city+', '+response[index].address.zipcode,
                                      style: TextStyle(fontSize: 12)
                                    )
                                  ]
                                )
                              ]
                            )
                          )
                        ]
                      )
                    );
                  }
                );
              }
            } else {
              return Container(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(
                        valueColor: animationController.drive(ColorTween(begin: Colors.blue, end: Colors.red)),
                      )
                    ],
                  ),
                ),
              );
            }
          },
        )
      )
    );
  }

  getUserProfile() {
    return Api.getUserProfile();
  }
}

/*
Here we can use ExpandablePanelList to implement ExpandableList in Flutter
ExpansionPanelList(
                animationDuration: Duration(seconds: 0),
                expansionCallback: (i, status) {
                  setState(() {
                    _activeMeterIndex = _activeMeterIndex == index ? null : index;
                  });
                },
                children: [
                  ExpansionPanel(
                    isExpanded: _activeMeterIndex == index,
                    headerBuilder: (context,isExpanded){
                      return ListTile(
                        title: Text('Ali Hasan'),
                      );
                    },  
                    body: ListTile(
                      dense: false,
                      title: Text(items[index]),
                      subtitle: Text('Subtitle of index ${index}'),
                    )
                  )
                ]
              )
*/
