import 'dart:isolate';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:test_app/networks/response/vaccination_response.dart';
import 'package:test_app/ui/keys_example/scroll_position_example.dart';
import 'dart:convert';

class IsolateExample extends StatefulWidget {
  const IsolateExample({Key? key}) : super(key: key);

  @override
  _IsolateExampleState createState() {
    print('LifeCycle => createState()');
    return _IsolateExampleState();
  }
}

class _IsolateExampleState extends State<IsolateExample> {

  var counter = 1;
  @override
  void initState() {
    print('LifeCycle => initState()');
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) => callVaccinationAPI());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    print('LifeCycle => didChangeDependenciesState()');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print('LifeCycle => buildState()');
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ScrollPositionExample())),
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("Isolate Example"),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            TextField(),
            Text('Counter Value $counter')
          ]
        )
      )
    );
  }

  @override
  void didUpdateWidget(covariant IsolateExample oldWidget) {
    print('LifeCycle => didUpdateWidgetState()');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    print('LifeCycle => deactivateState()');
    super.deactivate();
  }


  @override
  void dispose() {
    print('LifeCycle => disposeState()');
    super.dispose();
  }



  void callVaccinationAPI() async {
    final data = await _fetchBackgroundData();
    print(data);
  }

  Future<dynamic> _fetchBackgroundData() async {
    final p = ReceivePort();
    await Isolate.spawn(_backgroundTask, p.sendPort);
    return await p.first;
  }

}

//this method should be top level function because the isolate does not share the memory between the thread 
Future _backgroundTask(SendPort p) async {
  try {
    var response = await get(Uri.parse('https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/vaccinations/vaccinations.json'));
    if (response.statusCode == 200) {
      final data =  List<VaccinationResponse>.from(jsonDecode(response.body).map((e) => VaccinationResponse.fromJson(e)));
      Isolate.exit(p,data);
    }
    Isolate.exit(p,'Unavailable');
  } catch (e) {
    Isolate.exit(p,'Invalid request call');
  }
}


/**
 * ArgumentError (Invalid argument(s): Illegal argument in isolate message: (object extends NativeWrapper - Library:'dart:ui' Class: EngineLayer))
 * 
 * 
 * compute and Isolate.spawn can only take a top-level function, but not instance or static methods.

  Top-level functions are functions declared not inside a class and not inside another function
 *
 */
