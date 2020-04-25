import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  bool isSwitched = true;
  bool isSignal = true;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(int.parse("#144473".replaceAll("#", "0xff"))),
        centerTitle: true,
        title: Text('Settings')
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(15, 15, 15, 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                child: GestureDetector(
                  onTap: () => Toast.show('About',context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: Row(
                          children: <Widget>[
                            CircleAvatar(
                              child: new Image.asset('assets/images/about_device.png'),
                              radius: 20.0,
                              backgroundColor: Colors.transparent,
                            ),
                            SizedBox(width: 10.0),
                            Text(
                              'About Device',
                              style: TextStyle(color:Colors.black,fontFamily: 'MontserratSemiBold',fontSize:16.0),
                            )
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.navigate_next,
                          color: Colors.black38,
                          size: 40,
                        )
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                color: Colors.black26,
                thickness: 1.0,
                height: 15.0,
              ),
              Container(
                child: GestureDetector(
                  onTap: () => Toast.show('Interval',context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: Row(
                          children: <Widget>[
                            CircleAvatar(
                              child: new Image.asset('assets/images/interval.png'),
                              radius: 20.0,
                              backgroundColor: Colors.transparent
                            ),
                            SizedBox(width: 10.0),
                            Flexible(
                              child: Text(
                                'Interval for uploading location data',
                                style: TextStyle(color:Colors.black,fontFamily: 'MontserratSemiBold',fontSize: 16.0),
                                maxLines: 1,
                                overflow: TextOverflow.fade,
                                softWrap: false,
                              ),
                            )
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.navigate_next,
                          color: Colors.black38,
                          size: 40,
                        )
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                color: Colors.black26,
                thickness: 1.0,
                height: 15.0,
              ),
              Container(
                child: GestureDetector(
                  onTap: () => Toast.show('Main monitoring number',context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: Row(
                          children: <Widget>[
                            CircleAvatar(
                              child: new Image.asset('assets/images/monitoring.png'),
                              radius: 20.0,
                              backgroundColor: Colors.transparent,
                            ),
                            SizedBox(width: 10.0),
                            Text(
                              'Main monitoring number',
                              style: TextStyle(color:Colors.black,fontFamily: 'MontserratSemiBold',fontSize:16.0),
                            )
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.navigate_next,
                          color: Colors.black38,
                          size: 40,
                        )
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                color: Colors.black26,
                thickness: 1.0,
                height: 15.0,
              ),
              Container(
                child: GestureDetector(
                  onTap: () => Toast.show('The SOS list',context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: Row(
                          children: <Widget>[
                            CircleAvatar(
                              child: new Image.asset('assets/images/sos_list.png'),
                              radius: 20.0,
                              backgroundColor: Colors.transparent,
                            ),
                            SizedBox(width: 10.0),
                            Text(
                              'The SOS list',
                              style: TextStyle(color:Colors.black,fontFamily: 'MontserratSemiBold',fontSize:16.0),
                            )
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.navigate_next,
                          color: Colors.black38,
                          size: 40,
                        )
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                color: Colors.black26,
                thickness: 1.0,
                height: 15.0,
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          child: new Image.asset('assets/images/sensor_light.png'),
                          radius: 20.0,
                          backgroundColor: Colors.transparent,
                        ),
                        SizedBox(width: 10.0),
                        Text(
                          'Sensor light',
                          style: TextStyle(color:Colors.black,fontFamily: 'MontserratSemiBold',fontSize: 16.0),
                        )
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Switch(
                      value: isSwitched,
                      onChanged: (value) {
                        setState(() {
                          isSwitched = value;
                        });
                        Toast.show(value.toString().toUpperCase(), context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
                      },
                      activeTrackColor: Colors.green, 
                      activeColor: Colors.white,
                    ),
                  )
                ],
              ),
              Divider(
                color: Colors.black26,
                thickness: 1.0,
                height: 15.0,
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          child: new Image.asset('assets/images/signal_light.png'),
                          radius: 20.0,
                          backgroundColor: Colors.transparent,
                        ),
                        SizedBox(width: 10.0),
                        Text(
                          'Signal light',
                          style: TextStyle(color:Colors.black,fontFamily: 'MontserratSemiBold',fontSize: 16.0),
                        )
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Switch(
                      value: isSignal,
                      onChanged: (value) {
                        setState(() {
                          isSignal = value;
                        });
                        Toast.show(value.toString().toUpperCase(), context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
                      },
                      activeTrackColor: Colors.green, 
                      activeColor: Colors.white,
                    ),
                  )
                ],
              ),
              Divider(
                color: Colors.black26,
                thickness: 1.0,
                height: 15.0,
              ),
              Container(
                child: GestureDetector(
                  onTap: () => Toast.show('Remote reboot', context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: Row(
                          children: <Widget>[
                            CircleAvatar(
                              child: new Image.asset('assets/images/reboot.png'),
                              radius: 20.0,
                              backgroundColor: Colors.transparent,
                            ),
                            SizedBox(width: 10.0),
                            Text(
                              'Remote reboot',
                              style: TextStyle(color:Colors.black,fontFamily: 'MontserratSemiBold',fontSize: 16.0),
                            )
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.navigate_next,
                          color: Colors.black38,
                          size: 40,
                        )
                      )
                    ],
                  ),
                )
              ),
              Divider(
                color: Colors.black26,
                thickness: 1.0,
                height: 15.0,
              ),
              Container(
                child: GestureDetector(
                  onTap: () => Toast.show('Remote power-off', context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: Row(
                          children: <Widget>[
                            CircleAvatar(
                              child: new Image.asset('assets/images/power_off.png'),
                              radius: 20.0,
                              backgroundColor: Colors.transparent,
                            ),
                            SizedBox(width: 10.0),
                            Text(
                              'Remote power-off',
                              style: TextStyle(color:Colors.black,fontFamily: 'MontserratSemiBold',fontSize: 16.0),
                            )
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.navigate_next,
                          color: Colors.black38,
                          size: 40,
                        )
                      )
                    ],
                  ),
                )
              ),
              Divider(
                color: Colors.black26,
                thickness: 1.0,
                height: 15.0,
              ),
              Container(
                child: GestureDetector(
                  onTap: () => Toast.show('Factory-Reset', context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: Row(
                          children: <Widget>[
                            CircleAvatar(
                              child: new Image.asset('assets/images/reset.png'),
                              radius: 20.0,
                              backgroundColor: Colors.transparent,
                            ),
                            SizedBox(width: 10.0),
                            Text(
                              'Factory-Reset',
                              style: TextStyle(color:Colors.black,fontFamily: 'MontserratSemiBold',fontSize: 16.0),
                            )
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.navigate_next,
                          color: Colors.black38,
                          size: 40,
                        )
                      )
                    ],
                  ),
                )
              ),
              Divider(
                color: Colors.black26,
                thickness: 1.0,
                height: 15.0,
              )
            ]
          )
        )
      )
    );
  }
}