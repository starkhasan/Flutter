import 'package:flutter/material.dart';
import 'dart:math' as math;

class ScrollAnimation extends StatefulWidget {
  @override
  _ScrollAnimationState createState() => _ScrollAnimationState();
}

class _ScrollAnimationState extends State<ScrollAnimation> {
  var _horizontalList = List.generate(10, (index) => index + 1);
  var _verticalList = List.generate(50, (index) => index + 1);

  ScrollController scrollController;
  bool closeTopContainer = false;

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
    super.initState();
  } 

  _scrollListener() {
    if(scrollController.offset.round() > 10 && !closeTopContainer){
      setState(() {
        closeTopContainer = true;
      });
    }

    if(scrollController.offset.round() < 10 && closeTopContainer){
      setState(() {
        closeTopContainer = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Scroll Animation'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AnimatedOpacity(
              opacity: closeTopContainer ? 0 : 1,
              duration: Duration(milliseconds: 200),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.topCenter,
                height: closeTopContainer ? 0 : 150,
                child: _getHorizontalList(),
              )
            ),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: _verticalList.length,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.all(5),
                scrollDirection: Axis.vertical,
                itemBuilder: (context,index){
                  return Card(
                    elevation: 5,
                    color: Colors.red.shade100,
                    child: ListTile(
                      title: Text('Index $index')
                    )
                  );
                }
              )
            )
          ]
        ),
      ),
    );
  }

  Widget _getHorizontalList() {
   return Container(
      height: 150,
      padding: EdgeInsets.all(5),
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        padding: EdgeInsets.all(0),
        shrinkWrap: true,
        itemCount: _horizontalList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context,index){
          return Container(
            width: 100,
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.pink.shade100,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [BoxShadow(color: Colors.grey,blurRadius: 5.0)]
            ),
            child: ListTile(
              title: Text('Index $index'),
            ),
          );
        }
      )
    );
  }
}


