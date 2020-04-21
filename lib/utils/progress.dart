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
  String title;
  String icon;
  int createdBy;
  String userName;
  List<Topics> topics;

  Model(
      {this.modelID,
      this.title,
      this.icon,
      this.createdBy,
      this.userName,
      this.topics});

  Model.fromJson(Map<String, dynamic> json) {
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
  List<Text> text;
  List<Null> media;

  Content({this.contentID, this.articleID, this.text, this.media});

  Content.fromJson(Map<String, dynamic> json) {
    contentID = json['contentID'];
    articleID = json['ArticleID'];
    if (json['text'] != null) {
      text = new List<Text>();
      json['text'].forEach((v) {
        text.add(new Text.fromJson(v));
      });
    }
    if (json['Media'] != null) {
      media = new List<Null>();
      json['Media'].forEach((v) {
        media.add(new Null.fromJson(v));
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

class Text {
  int textID;
  int contentID;
  String contentText;
  int mediaOrder;
  String mediaType;

  Text(
      {this.textID,
      this.contentID,
      this.contentText,
      this.mediaOrder,
      this.mediaType});

  Text.fromJson(Map<String, dynamic> json) {
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