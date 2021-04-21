import 'package:flutter/material.dart';
import 'package:hello_flutter/providers/Counter.dart';
import 'package:provider/provider.dart';

class CounterScreen extends StatefulWidget {
  @override
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  var _listItem = List.generate(25, (index) => index + 1);

  var _listItemBool = List.generate(25, (index) => false);
  @override
  Widget build(BuildContext context) {
    print('Build Again');
    return ChangeNotifierProvider<Counter>(
      create: (context) => Counter(),
      child: Consumer<Counter>(
        builder: (context, counter, child) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('Checkbox ListTile'),
            ),
            body: Container(
              child: _getCheckBoxTile()
            ),
          );
        },
      ),
    );
  }

  Widget _getCheckBoxTile(){
    return ListView.builder(
      itemCount: _listItem.length,
      itemBuilder: (context,index){
        return Card(
          child: CheckboxListTile(
            title: Text('Check Mate'),
            secondary: Icon(Icons.unfold_more),
            controlAffinity: ListTileControlAffinity.leading,
            value: _listItemBool[index],
            onChanged: (value) {
              _listItemBool[index] = _listItemBool[index] ? false : true;
              setState(() {});
            }
          )
        );
      }
    );
  }
}
