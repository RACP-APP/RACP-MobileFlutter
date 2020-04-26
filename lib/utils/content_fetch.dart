import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/content.json');
}

Future<bool> get _localFileCheck async {
  final path = await _localPath;
  return File('$path/content.json').exists();
}

Future<File> writeContent(String content) async {
  final file = await _localFile;
  final exists = await _localFileCheck;
  file.createSync();
  print(exists);
  // Write the file.
  return file.writeAsString(content);
}

Future fetchContent() async {
    final response = await http.get('http://162.247.76.211:3000/JSONFile');

  // final response = await http.get('http://ncdp-dash.herokuapp.com/JSONFile');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    //return Content.fromJson(json.decode(response.body));
    //writeContent(response)
    
    writeContent(response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Content');
  }
}

Future<String> readJson() async {
  final file = await _localFile;

  // Read the file.
  String jsonString = file.readAsStringSync();
  //List<Map> parsedJson = json.decode(jsonString);
  return jsonString;
}

Future<List> stream() async {
  String dataString = await readJson();
  List items = json.decode(dataString);

  return items;
}
