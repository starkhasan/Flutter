import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/ui/Helper.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
                height: 50,
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.red, //                   <--- border color
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(
                            25.0) //                 <--- border radius here
                        )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        print("Clicked");
                      },
                      child: Text(
                        "Hello Everyone this is Ali Hasan,",
                        softWrap: false,
                        overflow: TextOverflow.fade,
                      ),
                    )),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => print("Clicked"),
                    )
                  ],
                )),
            SizedBox(height: 20),
            RaisedButton(
                child: Text('Press'),
                onPressed: () => {
                      Helper.isConnected().then((intenet) {
                        if (intenet != null && intenet) {
                          /*AwesomeDialog(
                              context: context,
                              headerAnimationLoop: false,
                              dismissOnTouchOutside: false,
                              dialogType: DialogType.NO_HEADER,
                              title: 'Online',
                              btnOkText: 'OK',
                              desc:
                                  'Your connection has been established',
                              btnOkColor: Colors.green,
                              btnOkOnPress: () {
                                debugPrint('OnClcik');
                              })
                            ..show();*/

                            AwesomeDialog(
                              context: context,
                              animType: AnimType.SCALE,
                              headerAnimationLoop: false,
                              dialogType: DialogType.SUCCES,
                              title: 'Online',
                              desc:
                                  'Your connection has been established',
                              btnOkOnPress: () {
                                debugPrint('OnClcik');
                              },
                              btnOkText: 'OK',
                              onDissmissCallback: () {
                                debugPrint('Dialog Dissmiss from callback');
                              })
                            ..show();
                        } else {
                          /*AwesomeDialog(
                              context: context,
                              headerAnimationLoop: false,
                              dismissOnTouchOutside: false,
                              dialogType: DialogType.NO_HEADER,
                              title: 'Connection Failed',
                              btnOkText: 'Close',
                              desc:
                                  'Please check your connection status and try again',
                              btnOkColor: Colors.red,
                              btnOkOnPress: () {
                                debugPrint('OnClcik');
                              })
                            ..show();*/
                            AwesomeDialog(
                              context: context,
                              animType: AnimType.SCALE,
                              headerAnimationLoop: false,
                              dialogType: DialogType.ERROR,
                              title: 'Connection Failed',
                              desc:
                                  'Please check your connection status and try again',
                              btnCancelOnPress: () {
                                debugPrint('OnClcik');
                              },
                              btnCancelText: 'Close',
                              onDissmissCallback: () {
                                debugPrint('Dialog Dissmiss from callback');
                              })
                            ..show();
                        }
                      }),
                    })
          ],
        ),
      ),
    );
  }
}
