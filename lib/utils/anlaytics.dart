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
    //Get the new ٌ that has been viewed to be saved.
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final progressFile = File('$path/progress.json');
    String progressFileContent = await progressFile.readAsString();
    Map<String, dynamic> jsonProgressData = jsonDecode(progressFileContent);
    Map<String, dynamic> jsonAnalyticData = new Map<String, dynamic>();
    jsonAnalyticData['savedToDb'] = jsonProgressData['savedToDb'];
    jsonAnalyticData['deviceId'] = jsonProgressData['deviceId'];
    jsonAnalyticData['data'] = new List();
    jsonProgressData['models'].forEach((model) {
      if (model["Topics"] != [] || model["Topics"] != null) {
        model["Topics"].forEach((topic) {
          if (topic["Article"] != [] || topic["Article"] != null) {
            topic["Article"].forEach((article) {
              jsonAnalyticData['data'].add({
                "ModelID": model["ModelID"],
                "TopicID": topic["TopicID"],
                "ArticleID": article["ArticleID"],
                "TimesViewed": article["TimesViewed"],
                "DurationViewd": article["DurationViewd"],
                "DateViewd": article["DateViewd"]
              });
            });
          }
        });
      }
    });

    print('*****************Analytics**************');
    print(jsonAnalyticData);
    print(jsonEncode(jsonAnalyticData));

    var response = await http.post(
      'http://162.247.76.211:3000/UpdateNotification',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(jsonAnalyticData),
    );
    print('Response status: ${response.statusCode}');
print('Response body: ${response.body}');
  } else {
    print('not connected');
  }
}
