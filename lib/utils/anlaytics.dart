import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:connectivity/connectivity.dart';
import '../utils/db.dart';
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
saveDuration(modelId, topicId, articleId, duration) async {
   await saveDurationDb(modelId, topicId, articleId, duration);
}
// saveDuration(modelId, topicId, articleId, duration) async {
//   final directory = await getApplicationDocumentsDirectory();
//   final path = directory.path;
//   final progressFile = File('$path/progress.json');
//   String progressFileContent = await progressFile.readAsString();
//   Map<String, dynamic> modelsList = jsonDecode(progressFileContent);
//   modelsList["models"].forEach((model) {
//     if (model["ModelID"] == modelId) {
//       List topics = model["Topics"];
//       for (final topic in topics) {
//         // myTopic = topic;
//         if (topic["TopicID"] == topicId) {
//           List articles = topic["Article"];
//           for (final article in articles) {
//             if (article["ArticleID"] == articleId) {
//               article["DurationViewd"] = article["DurationViewd"] + duration;
//             }
//           }
//         }
//       }
//       ;
//     }
//   });

//   var progressModelsJson = ProgressModels.fromJson(modelsList);
//   await progressFile.writeAsString(jsonEncode(progressModelsJson.toJson()));
// }

// Progress file convert to Json code
class ProgressModels {
  bool savedToDb;
  String deviceId;
  List<PModels> models;

  ProgressModels({this.savedToDb, this.deviceId, this.models});

  ProgressModels.fromJson(Map<String, dynamic> json) {
    savedToDb = json['savedToDb'];
    deviceId = json['deviceId'];
    if (json['models'] != null) {
      models = new List<PModels>();
      json['models'].forEach((v) {
        models.add(new PModels.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['savedToDb'] = this.savedToDb;
    data['deviceId'] = this.deviceId;
    if (this.models != null) {
      data['models'] = this.models.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PModels {
  int modelID;
  List<PTopics> topics;

  PModels({this.modelID, this.topics});

  PModels.fromJson(Map<String, dynamic> json) {
    modelID = json['ModelID'];
    if (json['Topics'] != null) {
      topics = new List<PTopics>();
      json['Topics'].forEach((v) {
        topics.add(new PTopics.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ModelID'] = this.modelID;
    if (this.topics != null) {
      data['Topics'] = this.topics.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PTopics {
  int topicID;
  int modelID;
  List<PArticle> article;

  PTopics({this.topicID, this.modelID, this.article});

  PTopics.fromJson(Map<String, dynamic> json) {
    topicID = json['TopicID'];
    modelID = json['ModelID'];
    if (json['Article'] != null) {
      article = new List<PArticle>();
      json['Article'].forEach((v) {
        article.add(new PArticle.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TopicID'] = this.topicID;
    data['ModelID'] = this.modelID;
    if (this.article != null) {
      data['Article'] = this.article.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PArticle {
  int articleID;
  int topicID;
  int timesViewed;
  int durationViewd;
  String dateViewd;

  PArticle(
      {this.articleID,
      this.topicID,
      this.timesViewed,
      this.durationViewd,
      this.dateViewd});

  PArticle.fromJson(Map<String, dynamic> json) {
    articleID = json['ArticleID'];
    topicID = json['TopicID'];
    timesViewed = json['TimesViewed'];
    durationViewd = json['DurationViewd'];
    dateViewd = json['DateViewd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ArticleID'] = this.articleID;
    data['TopicID'] = this.topicID;
    data['TimesViewed'] = this.timesViewed;
    data['DurationViewd'] = this.durationViewd;
    data['DateViewd'] = this.dateViewd;
    return data;
  }
}
