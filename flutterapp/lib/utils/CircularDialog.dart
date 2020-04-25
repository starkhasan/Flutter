import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

class CircularDialog{
  CircularDialog._();
  
  static ProgressDialog progressDialog(BuildContext context){
    ProgressDialog progressDialog = new ProgressDialog(context);
    progressDialog = new ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: true, showLogs: true);
    progressDialog.style(
      message: 'Loading...',
      borderRadius: 5.0,
      backgroundColor: Colors.white,
      progressWidget: Container(
        padding: EdgeInsets.all(8.0),
        child: CircularProgressIndicator()
      ),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progressTextStyle: TextStyle(
        color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
        color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600)
    );
    return progressDialog;
  } 
}