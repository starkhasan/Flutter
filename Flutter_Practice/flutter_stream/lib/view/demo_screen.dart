import 'package:flutter/material.dart';
import 'package:flutter_stream/view/todo_screen.dart';

// ignore: must_be_immutable
class DemoScreen extends StatefulWidget {
  int counter;
  final void Function()? onPress;
  DemoScreen({Key? key,required this.counter,required this.onPress}) : super(key: key);

  @override
  DemoScreenState createState() => DemoScreenState();
}

class DemoScreenState extends State<DemoScreen> {
  @override
  void initState() {
    print('Demo => Init State');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    print('Demo => Did Change Dependencies');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print('Demo => Build');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo Screen Lifecycle'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You have pushed the button this many times:'),
            Text(
              '${widget.counter}',
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(height: 8.0,),
            ElevatedButton(
              onPressed: widget.onPress,
              child: const Text('Reset count'),
            ),
            const SizedBox(height: 8.0,),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const TodoScreen()),
                );
              },
              child: const Text('Navigate to new route'),
            )
          ]
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      )
    );
  }

  void incrementCounter(){
    setState(() {
      widget.counter++;
    });
  }

  @override
  void didUpdateWidget(covariant DemoScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    /*
    * didUpdateWidget method called as we are resetting the counter value form the parent
    */
    print('Demo => didUpdateWidget');
    if (widget.counter != oldWidget.counter) {
      print('Count has changed');
    }
  }

  @override
  void deactivate() {
    print('Demo => DeActivate Widget');
    super.deactivate();
  }

  @override
  void dispose() {
    print('Demo => Dispose State');
    super.dispose();
  }
}
