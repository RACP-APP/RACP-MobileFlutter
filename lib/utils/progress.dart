import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';

// TODO get the progress info fot the modules
getOverallProgressPercent() async {
  double overallProgress = 1;
  final directory = await getApplicationDocumentsDirectory();
  final path = directory.path;
  final progressFile = File('$path/progress.json');
  String progressFileContent = await progressFile.readAsString();
  Map<String, dynamic> progressFileContentMap = jsonDecode(progressFileContent);

  progressFileContentMap["models"].forEach((model) {
    double modelProgress = getModelProgressPercent(model["ModelID"]);
    overallProgress *= modelProgress;
  });

  return overallProgress;
}

getModelProgressPercent(modelId) async {
  double modelProgress = 1;
  final directory = await getApplicationDocumentsDirectory();
  final path = directory.path;
  final progressFile = File('$path/progress.json');
  String progressFileContent = await progressFile.readAsString();
  Map<String, dynamic> progressFileContentMap = jsonDecode(progressFileContent);

  progressFileContentMap["models"].forEach((model) {
    if (model["ModelID"] == modelId) {
      if (model["Topics"] != null) {
        List topics = model["Topics"];
        topics.forEach((topic) {
          double topicProgress =
              getTopicProgressPercent(modelId, topic["TopicID"]);
          modelProgress *= topicProgress;
        });
      }
    }
  });

  return modelProgress;
}

// TODO get the progress info fot the topics
getTopicProgressPercent(modelId, topciId) async {
  int noOfArticles;
  int noOfArticlesViewd = 0;
  final directory = await getApplicationDocumentsDirectory();
  final path = directory.path;
  final progressFile = File('$path/progress.json');
  String progressFileContent = await progressFile.readAsString();
  Map<String, dynamic> progressFileContentMap = jsonDecode(progressFileContent);

  progressFileContentMap["models"].forEach((model) {
    if (model["ModelID"] == modelId) {
      if (model["Topics"] != null) {
        List topics = model["Topics"];
        topics.forEach((topic) {
          if (topic["TopicID"] == topciId) {
            if (topic["Article"] != null) {
              List articles = topic["Article"];
              articles.forEach((article) {
                var viewed =
                    getIfArticleViewed(modelId, topciId, article["ArticleID"]);
                if (viewed) {
                  noOfArticlesViewd++;
                }
              });
            }
          }
        });
      }
    }
  });

  return noOfArticlesViewd / noOfArticles;
}

//TODO get the progress info for the article
getIfArticleViewed(modelId, topciId, articleId) async {
  final directory = await getApplicationDocumentsDirectory();
  final path = directory.path;
  final progressFile = File('$path/progress.json');
  String progressFileContent = await progressFile.readAsString();
  Map<String, dynamic> progressFileContentMap = jsonDecode(progressFileContent);

  progressFileContentMap["models"].forEach((model) {
    if (model["ModelID"] == modelId) {
      if (model["Topics"] != null) {
        List topics = model["Topics"];
        topics.forEach((topic) {
          if (topic["TopicID"] == topciId) {
            if (topic["Article"] != null) {
              List articles = topic["Article"];
              articles.forEach((article) {
                if (article["ArticleID"] == articleId) {
                  return article["TimesViewed"] > 0;
                }
              });
            }
          }
        });
      }
    }
  });

  return false;
}

// get the device info
Future<List<String>> getDeviceDetails() async {
  String deviceName;
  String deviceVersion;
  String identifier;
  final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
  try {
    if (Platform.isAndroid) {
      var build = await deviceInfoPlugin.androidInfo;
      deviceName = build.model;
      deviceVersion = build.version.toString();
      identifier = build.androidId; //UUID for Android
    } else if (Platform.isIOS) {
      var data = await deviceInfoPlugin.iosInfo;
      deviceName = data.name;
      deviceVersion = data.systemVersion;
      identifier = data.identifierForVendor; //UUID for iOS
    }
  } on PlatformException {
    print('Failed to get platform version');
  }

//if (!mounted) return;
  return [deviceName, deviceVersion, identifier];
}

// check if the progress file exists
Future<void> checkProgressFile() async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final progressFile = File('$path/progress.json');
    final fileExists = await progressFile.exists();
    if (!fileExists) {
      // create the file
      progressFile.create().then((File file) async {
        // after the creation
        print('file created ');
        // read the content json file and write content with with the requried sturcture;
        var progressFileContent;
        var contentFileContent;

        final contentFile = File('$path/content.json');
        bool contentFileExists = await contentFile.exists();
        if (contentFileExists) {
          contentFileContent = await contentFile.readAsString();
          List<dynamic> modelsList = jsonDecode(contentFileContent);
          progressFileContent = ModelsList.fromJson(modelsList);
          String deviceId = (await getDeviceDetails())[2].toString();
          await file.writeAsString(
              jsonEncode(progressFileContent.toJson(false, deviceId)));
          // to change a value in a json file
          // String dd = await file.readAsString();

          // Map<String,dynamic> cc = jsonDecode(dd);
          // print(cc);
          // cc["models"].forEach((x){
          //   if(x["ModelID"]==9){
          //     List d= x["Topics"];
          //     d.forEach((f){
          //       if(f["TopicID"] == 16){
          //         List a = f["Article"];
          //         a.forEach((m){
          //           if(m["ArticleID"]== 17){
          //             m["TimesViewed"]++;
          //           }
          //         });
          //       }
          //     });
          //   }
          // });

          // await file.writeAsString(jsonEncode(cc));
        }
      });
    } else {
      print('file exists=================================================');
      // await progressFile.delete();
    }
  } catch (error) {
    print('=============================');
    print(error);
  }
  return;
}

class ModelsList {
  final List<Model> models;
  bool savedToDb = false;
  String deviceId = '';
  ModelsList({this.models, this.savedToDb, this.deviceId});

  factory ModelsList.fromJson(
    List<dynamic> parsedJson,
  ) {
    List<Model> models = new List<Model>();
    models = parsedJson.map((i) => Model.fromJson(i)).toList();
    return new ModelsList(models: models);
  }

  Map<String, dynamic> toJson(bool savedToDb, String deviceId) {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['savedToDb'] = savedToDb;
    data['deviceId'] = deviceId;
    if (this.models != null) {
      data['models'] = this.models.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Model {
  int modelID;
  List<Topics> topics;

  Model({this.modelID, this.topics});
  Model.fromJson(Map<String, dynamic> json) {
    modelID = json['ModelID'];
    if (json['Topics'] != null) {
      topics = new List<Topics>();
      json['Topics'].forEach((v) {
        topics.add(new Topics.fromJson(v));
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

class Topics {
  int topicID;
  int modelID;
  List<Article> article;

  Topics({this.topicID, this.modelID, this.article});

  Topics.fromJson(Map<String, dynamic> json) {
    topicID = json['TopicID'];
    modelID = json['ModelID'];
    if (json['Article'] != null) {
      article = new List<Article>();
      json['Article'].forEach((v) {
        article.add(new Article.fromJson(v));
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

class Article {
  int articleID;
  int topicID;
  int timesViewd;

  Article({
    this.articleID,
    this.topicID,
    this.timesViewd,
  });

  Article.fromJson(Map<String, dynamic> json) {
    articleID = json['ArticleID'];
    topicID = json['TopicID'];
    timesViewd = json['TimesViewd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ArticleID'] = this.articleID;
    data['TopicID'] = this.topicID;
    data['TimesViewed'] = this.timesViewd;
    data['DurationViewd'] = 0;
    data['DateViewd'] = (new DateTime.now()).toString();

    return data;
  }
}
