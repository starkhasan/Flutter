import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/utils/LanguageSettings/Languages.dart';

class AppLifeCycle extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppLifeCycle();
}

class _AppLifeCycle extends State<AppLifeCycle> with WidgetsBindingObserver{
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    print("Init State");
  }

  @override
  Widget build(BuildContext context) {
    print("Build State");
    return Scaffold(
      appBar: AppBar(
        title: Text(Languages.of(context).appLifeCycle),
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.blue,
              height: 50.0,
              width: 50.0,
            ),
            Icon(Icons.adjust, size: 50.0, color: Colors.pink),
            Icon(Icons.adjust, size: 50.0, color: Colors.purple,),
            Icon(Icons.adjust, size: 50.0, color: Colors.greenAccent,),
            Container(
              color: Colors.orange,
              height: 50.0,
              width: 50.0,
            ),
            Icon(Icons.adjust, size: 50.0, color: Colors.cyan,),
          ],
        )
      ),
    );
  }

  @override
  void didChangeDependencies() {
    print("Did Changed Dependencies");
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant AppLifeCycle oldWidget) {
    print("Did Update Widget");
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(fn) {
    print("Set State");
    super.setState(fn);
  }

  @override
  void deactivate() {
    print("Deactivate");
    super.deactivate();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    print("Dispose");
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
        print('appLifeCycleState inactive');
        break;
      case AppLifecycleState.resumed:
        print('appLifeCycleState resumed');
        break;
      case AppLifecycleState.paused:
        print('appLifeCycleState paused');
        break;
      default:
    }
  }
}
