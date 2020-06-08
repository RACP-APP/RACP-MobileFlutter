import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:connectivity/connectivity.dart';
import 'package:collection/collection.dart';
import '../utils/progress.dart';

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
  // Write the file.
  return file.writeAsString(content);
}

Future fetchContent() async {
  final exists = await _localFileCheck;
  if (!exists) {
    print(
        '***************************** Getting the contnet file from the server *****************************');
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      print('connected');
      final response = await http.get('http://162.247.76.211:3000/JSONFile');

      // final response = await http.get('http://ncdp-dash.herokuapp.com/JSONFile');

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        writeContent(response.body);
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        print(
            '********************* Need an Internet Connetion *********************');
        throw Exception('Failed to load Content');
      }
    } else {
      print(
          '********************* Need an Internet Connetion *********************');
    }
  } else {
    print(
        '************************* Content file already exisits *************************');
        addNewContentToProgressFile();
    // final file = await _localFile;
    // print('deleteingdddddddddddddddddddddddddddddddddddddddddddddd');
    // await file.delete();
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

addNewContentToContentFile() async {
  final path = await _localPath;
  File newContentFile = File('$path/newContent.json');
  File contentFile = File('$path/content.json');
  newContentFile.exists().then((exists) async {
    if (exists) {
      var newContentFileContent = await newContentFile.readAsString();
      List<dynamic> newModelsList = jsonDecode(newContentFileContent);
      var contentFileContent = await contentFile.readAsString();
      List<dynamic> modelsList = jsonDecode(contentFileContent);
      Function unOrdDeepEq = const DeepCollectionEquality.unordered().equals;
      if (!unOrdDeepEq(newModelsList, modelsList)) {
        for (var nmodel in newModelsList) {
          var modelExists = false;
          for (var model in modelsList) {
            if (nmodel['ModelID'] == model['ModelID']) {
              modelExists = true;
              if (!unOrdDeepEq(nmodel, model)) {
                // iterate topics
                for (var ntopic in nmodel["Topics"]) {
                  var topicExists = false;
                  for (var topic in model["Topics"]) {
                    if (ntopic['TopicID'] == topic['TopicID']) {
                      topicExists = true;
                      if (!unOrdDeepEq(ntopic, topic)) {
                        // iterate articles
                        for (var narticle in ntopic["Article"]) {
                          var articleExists = false;
                          for (var article in topic["Article"]) {
                            if (narticle['ArticleID'] == article['ArticleID']) {
                              articleExists = true;
                              if (!unOrdDeepEq(narticle, article)) {
                                // replace content
                                article['content'] = narticle['content'];
                                article['TimesViewd'] = 0; // reset
                              } else {
                                break;
                              }
                            }
                          }
                          if (!articleExists) {
                            topic["Article"].add(narticle);
                            print('iiiiiiiiiiiiiiiiiiiiiiiiiiii');
                            print('article adeded');
                            print(narticle['Title']);
                            print(topic["Article"]);
                          }
                        }
                      } else {
                        break;
                      }
                    }
                  }
                  if (!topicExists) {
                    model["Topics"].add(ntopic);
                    print('iiiiiiiiiiiiiiiiiiiiiiiiiiii');
                    print('topic adeded');
                    print(ntopic['Title']);
                    print(model["Topics"]);
                  }
                }
              } else {
                break;
              }
            }
          }

          if (!modelExists) {
            modelsList.add(nmodel);
            print('iiiiiiiiiiiiiiiiiiiiiiiiiiii');
            print('model adeded');
            print(nmodel['Title']);
            print(modelsList);
          }
        }
      }
      contentFile.writeAsString(jsonEncode(modelsList));
    }
  });
}

class OriginalModelsList {
  final List<OriginalModel> models;

  OriginalModelsList({this.models});

  factory OriginalModelsList.fromJson(
    List<dynamic> parsedJson,
  ) {
    List<OriginalModel> models = new List<OriginalModel>();
    models = parsedJson.map((i) => OriginalModel.fromJson(i)).toList();
    return new OriginalModelsList(models: models);
  }

  Map<String, dynamic> toJson(bool savedToDb, String deviceId) {
    Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.models != null) {
      data['models'] = this.models.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OriginalModel {
  int modelID;
  String title;
  String icon;
  int createdBy;
  String userName;
  List<Topics> topics;

  OriginalModel(
      {this.modelID,
      this.title,
      this.icon,
      this.createdBy,
      this.userName,
      this.topics});

  OriginalModel.fromJson(Map<String, dynamic> json) {
    modelID = json['ModelID'];
    title = json['Title'];
    icon = json['Icon'];
    createdBy = json['CreatedBy'];
    userName = json['userName'];
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
    data['Title'] = this.title;
    data['Icon'] = this.icon;
    data['CreatedBy'] = this.createdBy;
    data['userName'] = this.userName;
    if (this.topics != null) {
      data['Topics'] = this.topics.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Topics {
  int topicID;
  int modelID;
  String icon;
  String title;
  List<Article> article;

  Topics({this.topicID, this.modelID, this.icon, this.title, this.article});

  Topics.fromJson(Map<String, dynamic> json) {
    topicID = json['TopicID'];
    modelID = json['ModelID'];
    icon = json['Icon'];
    title = json['Title'];
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
    data['Icon'] = this.icon;
    data['Title'] = this.title;
    if (this.article != null) {
      data['Article'] = this.article.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Article {
  int articleID;
  int topicID;
  String icon;
  String title;
  String updateDate;
  int updateByUser;
  int createdByUser;
  String createdDate;
  int timesViewd;
  int timeSpendOnArticle;
  String notes;
  String createBy;
  String updatedBy;
  List<Content> content;

  Article(
      {this.articleID,
      this.topicID,
      this.icon,
      this.title,
      this.updateDate,
      this.updateByUser,
      this.createdByUser,
      this.createdDate,
      this.timesViewd,
      this.timeSpendOnArticle,
      this.notes,
      this.createBy,
      this.updatedBy,
      this.content});

  Article.fromJson(Map<String, dynamic> json) {
    articleID = json['ArticleID'];
    topicID = json['TopicID'];
    icon = json['Icon'];
    title = json['Title'];
    updateDate = json['UpdateDate'];
    updateByUser = json['UpdateByUser'];
    createdByUser = json['CreatedByUser'];
    createdDate = json['CreatedDate'];
    timesViewd = json['TimesViewd'];
    timeSpendOnArticle = json['TimeSpendOnArticle'];
    notes = json['Notes'];
    createBy = json['createBy'];
    updatedBy = json['UpdatedBy'];
    if (json['content'] != null) {
      content = new List<Content>();
      json['content'].forEach((v) {
        content.add(new Content.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ArticleID'] = this.articleID;
    data['TopicID'] = this.topicID;
    data['Icon'] = this.icon;
    data['Title'] = this.title;
    data['UpdateDate'] = this.updateDate;
    data['UpdateByUser'] = this.updateByUser;
    data['CreatedByUser'] = this.createdByUser;
    data['CreatedDate'] = this.createdDate;
    data['TimesViewd'] = this.timesViewd;
    data['TimeSpendOnArticle'] = this.timeSpendOnArticle;
    data['Notes'] = this.notes;
    data['createBy'] = this.createBy;
    data['UpdatedBy'] = this.updatedBy;
    if (this.content != null) {
      data['content'] = this.content.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Content {
  int contentID;
  int articleID;
  List<ContentText> text;
  List<Media> media;

  Content({this.contentID, this.articleID, this.text, this.media});

  Content.fromJson(Map<String, dynamic> json) {
    contentID = json['contentID'];
    articleID = json['ArticleID'];
    if (json['text'] != null) {
      text = new List<ContentText>();
      json['text'].forEach((v) {
        text.add(new ContentText.fromJson(v));
      });
    }
    if (json['Media'] != null) {
      media = new List<Media>();
      json['Media'].forEach((v) {
        media.add(new Media.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contentID'] = this.contentID;
    data['ArticleID'] = this.articleID;
    if (this.text != null) {
      data['text'] = this.text.map((v) => v.toJson()).toList();
    }
    if (this.media != null) {
      data['Media'] = this.media.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ContentText {
  int textID;
  int contentID;
  String contentText;
  int mediaOrder;
  String mediaType;

  ContentText(
      {this.textID,
      this.contentID,
      this.contentText,
      this.mediaOrder,
      this.mediaType});

  ContentText.fromJson(Map<String, dynamic> json) {
    textID = json['TextID'];
    contentID = json['ContentID'];
    contentText = json['ContentText'];
    mediaOrder = json['MediaOrder'];
    mediaType = json['MediaType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TextID'] = this.textID;
    data['ContentID'] = this.contentID;
    data['ContentText'] = this.contentText;
    data['MediaOrder'] = this.mediaOrder;
    data['MediaType'] = this.mediaType;
    return data;
  }
}

class Media {
  int mediaID;
  int contentID;
  String mediaLink;
  int mediaOrder;
  String mediaType;

  Media(
      {this.mediaID,
      this.contentID,
      this.mediaLink,
      this.mediaOrder,
      this.mediaType});

  Media.fromJson(Map<String, dynamic> json) {
    mediaID = json['MediaID'];
    contentID = json['ContentID'];
    mediaLink = json['MediaLink'];
    mediaOrder = json['MediaOrder'];
    mediaType = json['MediaType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MediaID'] = this.mediaID;
    data['ContentID'] = this.contentID;
    data['MediaLink'] = this.mediaLink;
    data['MediaOrder'] = this.mediaOrder;
    data['MediaType'] = this.mediaType;
    return data;
  }
}
