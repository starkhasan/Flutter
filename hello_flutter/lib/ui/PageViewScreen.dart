import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'package:page_view_indicators/page_view_indicators.dart';

class PageViewScreen extends StatefulWidget {
  @override
  _PageViewScreenState createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {
  PageController _pageController;
  var currentPage = 0;
  final _currentPageNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    _pageController = PageController();

    Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (currentPage < 2) {
        currentPage++;
      } else {
        currentPage = 0;
      }
      _pageController.animateToPage(
        currentPage,
        duration: Duration(milliseconds: 350),
        curve: Curves.easeIn
      );
      setState(() {
        _currentPageNotifier.value = currentPage;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Page View'),
        ),
        body: Stack(
            children: [PageView(
              controller: _pageController,
              pageSnapping: true,
              onPageChanged: (value) {
                setState(() {
                  currentPage = value;
                  _currentPageNotifier.value = value;
                });
              },
              children: [
                Container(
                  color: Colors.red,
                  child: Center(
                    child: Text(
                      'Page 1',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                    color: Colors.pink,
                    child: Center(
                      child: Text(
                        'Page 2',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    )),
                Container(
                    color: Colors.yellow,
                    child: Center(
                      child: Text(
                        'Page 3',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ))
              ],
            ),
            Positioned(
                left: 0.0,
                right: 0.0,
                bottom: 0.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CirclePageIndicator(
                    itemCount: 3,
                    selectedDotColor: Colors.black,
                    dotColor: Colors.white,
                    currentPageNotifier: _currentPageNotifier,
                  ),
                ),
              )
            ]
          ),
      );
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
