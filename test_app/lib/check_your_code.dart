import 'package:http/http.dart' as http;
import 'dart:isolate';
import 'dart:convert';

void main(List<String> args) async {
  var heavyData = await isolateExample();
  print(heavyData);
}

Future isolateExample() async {
  final jsonData = await _parseInBackground();
  return jsonData;
}

Future<Map<String, dynamic>> _parseInBackground() async {
  final p = ReceivePort();
  await Isolate.spawn(_readAndParseJson, p.sendPort);
  return await p.first;
}


Future<dynamic> _readAndParseJson(SendPort p) async{
  final fileData = await http.get(Uri.parse('https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/vaccinations/vaccinations.json'));
  final jsonData = jsonDecode(fileData.body);
  Isolate.exit(p, jsonData);
}
