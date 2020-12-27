import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpandableCardList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ExpandableCardList();
}

class _ExpandableCardList extends State<ExpandableCardList> {
  final items = List.generate(10, (i) => "Item ${i + 1}");
  var _activeMeterIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expandable Card'),
        centerTitle: true,
      ),
      body: Container(
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Card(
              child: ExpansionPanelList(
                animationDuration: Duration(seconds: 1),
                expansionCallback: (i, status) {
                  setState(() {
                    _activeMeterIndex = _activeMeterIndex == index ? null : index;
                  });
                },
                children: [
                  ExpansionPanel(
                    isExpanded: _activeMeterIndex == index,
                    headerBuilder: (context,isExpanded){
                      return ListTile(
                        title: Text('Ali Hasan'),
                      );
                    },  
                    body: ListTile(
                      dense: false,
                      title: Text(items[index]),
                      subtitle: Text('Subtitle of index ${index}'),
                    )
                  ),
                ],
              )
            );
          }
        ),
      ),
    );
  }
}
