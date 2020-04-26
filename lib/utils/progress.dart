import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
<<<<<<< HEAD
import 'package:provider/provider.dart';
import 'content_fetch.dart';

Future<File> get checkProgressFile async {
=======
import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';

Future<void> setArticleCompleted(modelId, topicId, articleId) async {
  final directory = await getApplicationDocumentsDirectory();
  final path = directory.path;
  final progressFile = File('$path/progress.json');
  String progressFileContent = await progressFile.readAsString();
  Map<String, dynamic> modelsList = jsonDecode(progressFileContent);
  modelsList["models"].forEach((model) {
    if (model["ModelID"] == modelId) {
      List topics = model["Topics"];
      topics.forEach((topic) {
        if (topic["TopicID"] == topicId) {
          List articles = topic["Article"];
          articles.forEach((article) {
            if (article["ArticleID"] == articleId) {
              print('===============article is viewd ======================');
              article["TimesViewed"]++;
            }
          });
        }
      });
    }
  });

  var progressModelsJson = ProgressModels.fromJson(modelsList);
  await progressFile.writeAsString(jsonEncode(progressModelsJson.toJson()));
}

Future<double> getOverallProgressPercent() async {
  double overallProgress = 0;
  final directory = await getApplicationDocumentsDirectory();
  final path = directory.path;
  final progressFile = File('$path/progress.json');
  String progressFileContent = await progressFile.readAsString();
  Map<String, dynamic> progressFileContentMap = jsonDecode(progressFileContent);
  double modelProgress;
  for (final model in progressFileContentMap["models"]) {
    modelProgress = getModelProgressPercentSync(model);
    overallProgress += modelProgress;
  }

  return overallProgress / progressFileContentMap["models"].length;
}

Future<double> getModelProgressPercent(modelId) async {
  double modelProgress = 0;
  int noOfTopics = 1;
  final directory = await getApplicationDocumentsDirectory();
  final path = directory.path;
  final progressFile = File('$path/progress.json');
  String progressFileContent = await progressFile.readAsString();
  Map<String, dynamic> progressFileContentMap = jsonDecode(progressFileContent);

  for (final model in progressFileContentMap["models"]) {
    if (model["ModelID"] == modelId) {
      if (model["Topics"] != null && model["Topics"].length != 0) {
        List topics = model["Topics"];
        noOfTopics = model["Topics"].length;
        for (final topic in topics) {
          var topicProgress;
          topicProgress = getTopicProgressPercent(topic);
          modelProgress += topicProgress;         
        }
        return modelProgress / noOfTopics;
      }
    }
  }
}

double getModelProgressPercentSync(model) {
  double modelProgress = 0;
  int noOfTopics = 1;
  if (model["Topics"] != null && model["Topics"].length != 0) {
    List topics = model["Topics"];
    noOfTopics = model["Topics"].length;
    for (final topic in topics) {
      var topicProgress;
      topicProgress = getTopicProgressPercent(topic);
      modelProgress += topicProgress;
    }
    return modelProgress / noOfTopics;
  }
  return 0;
}

double getTopicProgressPercent(topic) {
  int noOfArticles = 1;
  int noOfArticlesViewd = 0;
  if (topic["Article"] != null && topic["Article"].length != 0) {
    noOfArticles = topic["Article"].length;
    List articles = topic["Article"];
    for (final article in articles) {
      if (article["TimesViewed"] > 0) {
        noOfArticlesViewd++;
      }
    }
    return noOfArticlesViewd / noOfArticles;
  }
  return 0;
}

Future<bool> getIfArticleViewed(modelId, topciId, articleId) async {
  bool viewed = false;
  final directory = await getApplicationDocumentsDirectory();
  final path = directory.path;
  final progressFile = File('$path/progress.json');
  String progressFileContent = await progressFile.readAsString();
  Map<String, dynamic> progressFileContentMap = jsonDecode(progressFileContent);

  for (final model in progressFileContentMap["models"]) {
    if (model["ModelID"] == modelId) {
      if (model["Topics"] != null && model["Topics"].length != 0) {
        List topics = model["Topics"];
        for (final topic in topics) {
          if (topic["TopicID"] == topciId) {
            if (topic["Article"] != null && topic["Article"].length != 0) {
              List articles = topic["Article"];
              for (final article in articles) {
                if (article["ArticleID"] == articleId) {
                  print('********article no ************');
                  print(article["ArticleID"]);
                  viewed = article["TimesViewed"] > 0;
                                    print(article["TimesViewed"] > 0);

                  return viewed;
                }
              }
          
            }
          }
        }
      }
    }
  }
  return viewed;
}

Future<bool> getIfAllArticlesViewed(modelId, topicId) async {
  final directory = await getApplicationDocumentsDirectory();
  final path = directory.path;
  final progressFile = File('$path/progress.json');
  String progressFileContent = await progressFile.readAsString();
  Map<String, dynamic> progressFileContentMap = jsonDecode(progressFileContent);
  bool allArticlesViewed = true;
  for (final model in progressFileContentMap["models"]) {
    if (model["ModelID"] == modelId) {
      if (model["Topics"] != null && model["Topics"].length != 0) {
        List topics = model["Topics"];
        for (final topic in topics) {
          if (topic["TopicID"] == topicId) {
            if (topic["Article"] != null && topic["Article"].length != 0) {
              List articles = topic["Article"];
              for (final article in articles) {
                allArticlesViewed =
                    allArticlesViewed && article["TimesViewed"] > 0;
              }
              return allArticlesViewed;
            } else {
              return false;
            }
          }
        }
        ;
      }
    }
  }
  ;

  return allArticlesViewed;
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
>>>>>>> progress
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
<<<<<<< HEAD
          await progressFile.writeAsString(progressFileContent);
        }
      });
=======
          List<dynamic> modelsList = jsonDecode(contentFileContent);
          print('conten file ------------------------------');
          print(modelsList);
          progressFileContent = ModelsList.fromJson(modelsList);
          String deviceId = (await getDeviceDetails())[2].toString();
          print('progress file ------------------------------');
          print(progressFileContent.toJson(false, deviceId));
          await file.writeAsString(
              jsonEncode(progressFileContent.toJson(false, deviceId)));
        }
      });
    } else {
      print('file exists=================================================');
      // await progressFile.delete();
>>>>>>> progress
    }
  } catch (error) {
    print('=============================');
    print(error);
  }
<<<<<<< HEAD
=======
  return;
}

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

// Content file Convert to Json code
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
    data['deviceId'] = deviceId.toString();
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
>>>>>>> progress
}
