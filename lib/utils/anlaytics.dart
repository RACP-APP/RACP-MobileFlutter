import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:connectivity/connectivity.dart';

Future<void> saveAnalyticsToServer() async {
  // Check connectivity
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.wifi ||
      connectivityResult == ConnectivityResult.mobile) {
    print('connected');
    //Get the new article that has been viewed to be saved.
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final progressFile = File('$path/progress.json');
    String progressFileContent = await progressFile.readAsString();
    print('*****************Analytics**************');
    print(progressFileContent);
    await http.post(
      'http://162.247.76.211:3000/', // need updating
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(progressFileContent),
    );
  } else {
    print('not connected');
  }
}