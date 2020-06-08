import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';

Future<bool> setArticleCompleted(modelId, topicId, articleId) async {
  var myTopic;
  final directory = await getApplicationDocumentsDirectory();
  final path = directory.path;
  final progressFile = File('$path/progress.json');
  String progressFileContent = await progressFile.readAsString();
  print('22222222222222222222222222222222222222222222222222222222');
  print(progressFileContent);

  OpenFile.open('$path/progress.json');

  Map<String, dynamic> modelsList = jsonDecode(progressFileContent);
  modelsList["models"].forEach((model) {
    if (model["ModelID"] == modelId) {
      List topics = model["Topics"];
      for (final topic in topics) {
        myTopic = topic;
        if (topic["TopicID"] == topicId) {
          List articles = topic["Article"];
          for (final article in articles) {
            if (article["ArticleID"] == articleId) {
              article["TimesViewed"]++;
            }
          }
        }
      }
    }
  });
  var progressModelsJson = ProgressModels.fromJson(modelsList);
  await progressFile.writeAsString(jsonEncode(progressModelsJson.toJson()));
  return getIfAllArticlesViewedSync(myTopic);
}

Future<double> getOverallProgressPercent() async {
  print('helooo form oaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
  double overallProgress = 0.0;
  final directory = await getApplicationDocumentsDirectory();
  final path = directory.path;
  final progressFile = File('$path/progress.json');
  String progressFileContent = await progressFile.readAsString();
  Map<String, dynamic> progressFileContentMap = jsonDecode(progressFileContent);
  double modelProgress;
  print('ssssssssssseeeeeeeeeeeeeeSeeeeeeeee');
  print(progressFileContentMap["models"].length);
  for (final model in progressFileContentMap["models"]) {
    modelProgress = getModelProgressPercentSync(model);

    print(modelProgress);
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
  for (var model in progressFileContentMap["models"]) {
    if (model["ModelID"] == modelId) {
      if (model["Topics"] != null && model["Topics"].length != 0) {
        List topics = model["Topics"];
        noOfTopics = model["Topics"].length;
        for (final topic in topics) {
          var topicProgress;
          print('tttttttttttttttt');
          topicProgress = getTopicProgressPercent(topic);
          modelProgress += topicProgress;
        }
        return modelProgress / noOfTopics;
      }
    }
  }
  return modelProgress / noOfTopics;
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
                  viewed = article["TimesViewed"] > 0;
                  return viewed;
                }
              }
            }
          }
        }
      }
    }
  }
}

bool getIfAllArticlesViewedSync(topic) {
  bool allArticlesViewed = true;

  if (topic["Article"] != null && topic["Article"].length != 0) {
    List articles = topic["Article"];
    for (final article in articles) {
      allArticlesViewed = allArticlesViewed && article["TimesViewed"] > 0;
    }
    return allArticlesViewed;
  } else {
    return false;
  }
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
      }
    }
  }
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
      // OpenFile.open('$path/progress.json');
      //  await progressFile.delete();
    }
  } catch (error) {
    print(error);
  }
  return;
}

addNewContentToProgressFile() async {
  final directory = await getApplicationDocumentsDirectory();
  final path = directory.path;
  File progressFile = File('$path/progress.json');
  File contentFile = File('$path/content.json');
  contentFile.exists().then((exists) async {
    if (exists) {
      var contentFileContent = await contentFile.readAsString();
      List<dynamic> modelsList = jsonDecode(contentFileContent);
      var progressFileContent = await progressFile.readAsString();
      Map<String, dynamic> progressModelsList = jsonDecode(progressFileContent);
      print('888888888888888progress model lists8888888888888888888');
      print(progressModelsList.runtimeType);
      print(progressModelsList);
      for (var model in modelsList) {
        print('iterating the models in content *****************');
        var modelExists = false;
        for (var pmodel in progressModelsList['models']) {
          print('iterating the models in progress *****************');

          if (model['ModelID'] == pmodel['ModelID']) {
            print(
                'iterating the models in progress Model Match::::*****************');

            modelExists = true;
            // iterate topics
            for (var topic in model["Topics"]) {
              print(
                  'iterating the topics of model in content *****************');

              var topicExists = false;
              for (var ptopic in pmodel["Topics"]) {
                print(
                    'iterating the topcis in progress Model Match::::*****************');

                if (topic['TopicID'] == ptopic['TopicID']) {
                  print(
                      'iterating the topics in progress topic Match::::*****************');
                  topicExists = true;
                  // iterate articles
                  for (var article in topic["Article"]) {
                    print(
                        'iterating the articles in content :::*****************');
                    var articleExists = false;
                    for (var particle in ptopic["Article"]) {
                      print(
                          'iterating the articles in progress :::*****************');
                      if (article['ArticleID'] == particle['ArticleID']) {
                        print(
                            'iterating the articles in progress article Match::::*****************');
                        articleExists = true;
                        // TODO COMPAE CONTENT
                        // TODO ITERATE THROUGH CONTENT TO MAKE SURE IT IS UPDATED.
                        // particle['TimesViewd'] = 0; // reset

                      }
                    }
                    if (!articleExists) {
                      print('adding new article **************************');
                      print(ptopic["Article"]);
                      print('9999999999999999999');
                      print(P1Article.fromJson(article).toJson());
                      ptopic["Article"]
                          .add(P1Article.fromJson(article).toJson());
                      print('33333333333333333333333');
                      print(ptopic["Article"]);
                    }
                  }
                }
              }
              if (!topicExists) {
                print('adding new topic **************************');

                pmodel["Topics"].add(PTopics.fromJson(topic));
              }
            }
          }
        }

        if (!modelExists) {
          print(
              'iterating the models in progress adding new m odel no match *****************');

          progressModelsList['models'].add(PModels.fromJson(model));

          print(model);
        }
      }

      progressFile.writeAsString(jsonEncode(progressModelsList));
    }
  });
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

class P1Article {
  int articleID;
  int topicID;
  int timesViewed;
  int durationViewd;
  String dateViewd;
  P1Article(
      {this.articleID,
      this.topicID,
      this.timesViewed,
      this.durationViewd,
      this.dateViewd});

  P1Article.fromJson(Map<String, dynamic> json) {
    articleID = json['ArticleID'];
    topicID = json['TopicID'];
    timesViewed = 0;
    durationViewd = 0;
    dateViewd = '';
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
    // timesViewd = json['TimesViewd'];
    timesViewd = 0;
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
