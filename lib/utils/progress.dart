import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'content_fetch.dart';

Future<File> get checkProgressFile async {
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
          var contentFileContentAsJson =  contentFileContent.decode();
          await progressFile.writeAsString(progressFileContent);
        }
      });
    }
  } catch (error) {
    print('=============================');
    print(error);
  }
}


class Model {
  int modelID;
  List<Topics> topics;

  Model(
      {this.modelID,
      this.topics});

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

  Topics({this.topicID, this.modelID,  this.article});

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

  Article(
      {this.articleID,
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
    data['TimesViewd'] = this.timesViewd;
    return data;
  }
}
