import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/utils/LanguageSettings/Languages.dart';

class AppLifeCycle extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppLifeCycle();
}

class _AppLifeCycle extends State<AppLifeCycle> {
  @override
  void initState() {
    super.initState();
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
        child: Center(
          child: TextField(
            
          )
        ),
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
    print("Dispose");
    super.dispose();
  }
}
