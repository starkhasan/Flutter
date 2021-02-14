import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/utils/Helper.dart';

class CupertinoScreen extends StatefulWidget {
  @override
  _CupertinoScreenState createState() => _CupertinoScreenState();
}

class _CupertinoScreenState extends State<CupertinoScreen> {
  var switchValue = false;
  var selectedCountry = 'India';
  var _initialPosition = 0;
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Cupertino Style'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          var tempCountry = selectedCountry;
          var tempPos = _initialPosition;
          var data = await _showCupertinoPicker();
          if(data == 'cancel'){
            setState(() {
              selectedCountry = tempCountry;
              _initialPosition = tempPos;
            });
          }
        },
        child: Icon(Icons.add),
      ),
      body: Container(
          child: Column(
        children: [
          Container(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Cupertino Switch'),
                  CupertinoSwitch(
                    value: switchValue,
                    activeColor: Colors.green,
                    onChanged: (value) {
                      setState(() {
                        switchValue = value;
                      });
                    },
                  )
                ],
              )),
          Container(
            child: CupertinoButton(
              onPressed: () => print('Click'),
              color: Colors.blue,
              child: Text("Click Me!"),
            ),
          )
        ],
      )),
    );
  }

  _showCupertinoPicker() async{
    var data =  await showGeneralDialog(
      barrierLabel: 'Label1',
      barrierDismissible: false,
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {  
        return StatefulBuilder(
          builder: (context,setState){
            return Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CupertinoButton(
                          padding: EdgeInsets.all(20),
                          onPressed: () => Navigator.pop(context,'cancel'),
                          child: Text('Cancel',style: TextStyle(color: Colors.red)),
                        ),
                        CupertinoButton(
                          padding: EdgeInsets.all(20),
                          onPressed: () => Navigator.pop(context,'submit'),
                          child: Text('Submit',style: TextStyle(color: Colors.blue)),
                        )
                      ],
                    ),
                    Expanded(
                      child: CupertinoPicker(
                        itemExtent: 40,
                        scrollController: FixedExtentScrollController(initialItem: _initialPosition),
                        onSelectedItemChanged: (value) {
                          setState((){
                            _initialPosition = value;
                            selectedCountry = Helper.getCountry()[value];
                          });
                        },
                        children: Helper.getCountryList()
                      )
                    )
                  ],
                )
              )
            );
          }
        );
      }
    );
    return data;
  }
}
