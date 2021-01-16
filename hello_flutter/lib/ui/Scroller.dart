import 'package:flutter/material.dart';
import 'package:flutter_progress_dialog/flutter_progress_dialog.dart';

class Scroller extends StatefulWidget {
  @override
  _ScrollerState createState() => _ScrollerState();
}

class _ScrollerState extends State<Scroller> {
  ScrollController _scrollController;
  var isTopVisible = false;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    if (_scrollController.offset > _scrollController.position.minScrollExtent) {
      if(!isTopVisible){
        setState(() {
          isTopVisible = true;
        });
      }
    } else {
      if(isTopVisible){
        setState(() {
          isTopVisible = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ProgressDialog(
      loadingText: 'Loading...',
      child: Scaffold(
        floatingActionButton: isTopVisible
            ? FloatingActionButton(
                onPressed: () {
                  _scrollController.animateTo(
                    0.0,
                    curve: Curves.easeInOut,
                    duration: Duration(milliseconds: 500)
                  );
                },
                child: Icon(Icons.keyboard_arrow_up),
              )
            : null,
        appBar: AppBar(
          centerTitle: true,
          title: Text('Scroller'),
        ),
        body: Container(child: getList()),
      ),
    );
  }

  Widget getList() {
    return ListView.builder(
      controller: _scrollController,
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: 30,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () => print('${index} Click'),
          child: Card(
            child: ListTile(
              dense: false,
              leading: Icon(Icons.home),
              title: Text('Index ${index}'),
              subtitle: Text('This is Subtitle'),
            )
          ),
        );
      },
    );
  }
}
