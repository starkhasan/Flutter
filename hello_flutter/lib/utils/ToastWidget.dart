import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastWidget extends StatelessWidget {
  final String message;
  ToastWidget({this.message});
  @override
  Widget build(BuildContext context) => RaisedButton(
      onPressed: () => showToast(),
      child: Text('Click Me'),
    );

  void showToast(){
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0
    );
  }
}
