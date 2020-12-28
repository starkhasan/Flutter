import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/utils/LanguageSettings/Languages.dart';


class SwipeDeleteScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SwipeDeleteScreen();
}

class _SwipeDeleteScreen extends State<SwipeDeleteScreen> {
  List<String> items = ['Ali', 'Hasan', 'Shahid'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Languages.of(context).swipeTitle),
        centerTitle: true,
      ),
      body: Container(
        child: RefreshIndicator(
          displacement: 40.0,
          strokeWidth: 2.0, 
          onRefresh: _refreshList,
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Dismissible(
                  dismissThresholds: {
                    DismissDirection.startToEnd: 0.2,
                    DismissDirection.endToStart: 0.2
                  },
                  key: Key(items[index]),
                  background: _getPrimaryWidget(),
                  secondaryBackground: _getSceondaryWidget(),
                  confirmDismiss: (direction) async {
                    if (direction == DismissDirection.endToStart) {
                      final bool res = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Text(
                                  "Are you sure you want to Archived ${items[index]}?"),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                FlatButton(
                                  child: Text(
                                    "Archived",
                                    style: TextStyle(color: Colors.green),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      items.removeAt(index);
                                    });
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          });
                      return res;
                    } else {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Text(
                                  "Are you sure you want to Delete ${items[index]}?"),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                FlatButton(
                                  child: Text(
                                    "Delete",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      items.removeAt(index);
                                    });
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          }
                        );
                    }
                  },
                  child: Card(
                    child: ListTile(
                      dense: true,
                      title: Text(items[index]),
                    ),
                  )
                );
          }
        ),
        )
      ),
    );
  }

   Future<Null> _refreshList() async{
     List<String> newItems = ['Ali', 'Hasan', 'Shahid','Nabdul','Nezdil','Lalu','Chati'];
     await Future.delayed(Duration(seconds: 2));
     setState(() {
       items = newItems;
     });
  }

  Widget _getSceondaryWidget() {
    return Container(
      color: Colors.green,
      child: Align(
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(Icons.archive, color: Colors.white),
            Text(
              "Archived",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(width: 20)
          ],
        ),
      ),
    );
  }

  Widget _getPrimaryWidget() {
    return Container(
      color: Colors.red,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(width: 20),
            Icon(Icons.delete, color: Colors.white),
            Text(
              "Delete",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.right,
            )
          ],
        ),
      ),
    );
  }
}
