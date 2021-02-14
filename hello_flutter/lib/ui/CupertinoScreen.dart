import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/utils/Helper.dart';

class CupertinoScreen extends StatefulWidget {
  @override
  _CupertinoScreenState createState() => _CupertinoScreenState();
}

class _CupertinoScreenState extends State<CupertinoScreen> {
  var switchValue = false;
  var setectedCountry = 'India';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Cupertino Style'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCupertinoPicker(),
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

  _showCupertinoPicker() {
    showGeneralDialog(
      barrierLabel: 'Label1',
      barrierDismissible: true,
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
                child: CupertinoPicker(
                  itemExtent: 40,
                  useMagnifier: true,
                  onSelectedItemChanged: (value) {
                    setState((){
                      setectedCountry = Helper.getCountryList()[value].data;
                    });
                  },
                  children: Helper.getCountryList()
                )
              ),
            );
          }
        );
      }
    );
  }
}
