
import 'package:flutter/material.dart';

class ProgressDialog {
  late BuildContext buildContext;
  bool isLoading = false;
  Color? loadingColor;
  String? text;
  ProgressDialog({required this.buildContext,this.loadingColor,this.text}){
    buildContext = buildContext;
    loadingColor = loadingColor;
    text = text;
  }

  show() {
    isLoading = true;
    return showDialog(
      barrierDismissible: false,
      context: buildContext, 
      builder: (context) {
        return WillPopScope(
          onWillPop: () async{
            isLoading = false;
            return await Future.value(true);
          },
          child: Dialog(
            child: Container(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 35,
                    height: 35,
                    child: CircularProgressIndicator(backgroundColor: Colors.white,color: loadingColor ??= Colors.blue)
                  ),
                  const SizedBox(width: 20),
                  Text(text ??= 'Loading...',style: const TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 17))
                ]
              )
            )
          )
        );
      }
    );
  }

  hide(){
    if(isLoading) Navigator.pop(buildContext);
  }
}
