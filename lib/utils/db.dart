import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// Open the database and store the reference.
Future<Database> openDb() async {
  final Future<Database> database = openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    join(await getDatabasesPath(), 'ncdp_database.db'),
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      db.execute(
          "CREATE TABLE MODELS(MODEL_ID INTEGER PRIMARY KEY, TITLE TEXT, ICON TEXT, MODEL_ORDER INTEGER, TO_BE_DELETED INTEGER)");
      db.execute(
          "CREATE TABLE TOPICS(TOPIC_ID INTEGER ,MODEL_ID INTEGER , TITLE TEXT, ICON TEXT, TO_BE_DELETED INTEGER)");
      db.execute(
          "CREATE TABLE ATRICLES(ARTICLE_ID INTEGER ,TOPIC_ID INTEGER ,MODEL_ID INTEGER , TITLE TEXT, ICON TEXT," +
              "UPDATE_DATE TEXT, CREATED_DATE TEXT, VIEWED INTEGER, TIMES_VIEWED INTEGER, TIME_SPENT_ON_ARTICLE INTEGER, DATE_VIEWED TEXT, ANALYTICS_SAVED INTEGER, TO_BE_DELETED INTEGER)");
      db.execute(
          "CREATE TABLE CONTENT(ID INTEGER, CONTENT_ID INTEGER, ARTICLE_ID INTEGER ,TOPIC_ID INTEGER ,MODEL_ID INTEGER ," +
              "CONTENT_DETIALS TEXT,CONTENT_TYPE TEXT,CONTENT_ORDER INTEGER, TO_BE_DELETED INTEGER)");
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.

    version: 1,
  );

  return database;
}

class Model {
  int modelId;
  String title;
  String icon;
  int modelOrder;
  int toBeDeleted;

  Model(this.modelId, this.title, this.icon, this.modelOrder, this.toBeDeleted);
  Map<String, dynamic> toMap() {
    return {
      'MODEL_ID': modelId,
      'TITLE': title,
      'ICON': icon,
      'MODEL_ORDER': modelOrder,
      'TO_BE_DELETED': toBeDeleted
    };
  }
}

Future<void> insertModel(Model model) async {
  // Get a reference to the database.
  final Database db = await openDb();

  // Insert the model into the correct table. You might also specify the
  // `conflictAlgorithm` to use in case the same dog is inserted twice.
  //
  // In this case, replace any previous data.
  await db.insert('MODELS', model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace);
}

Future<List<Map>> getModels() async {
  // Get a reference to the database.
  final Database db = await openDb();

  // Query the table for all The Models.
  return await db.rawQuery('SELECT * FROM MODELS ORDER BY MODEL_ORDER ASC');
}

Future<List> getModelById(int modelId) async {
  // Get a reference to the database.
  final Database db = await openDb();
  return await db.query('MODELS', where: "MODEL_ID = ?", whereArgs: [modelId]);
}

Future<void> updateModel(Model model) async {
  // Get a reference to the database.
  final Database db = await openDb();
  await db.update('MODELS', model.toMap(),
      where: "MODEL_ID = ?", whereArgs: [model.modelId]);
}

// Future<void> deleteModel(int modelId) async {
//   // Get a reference to the database.
//   final Database db = await openDb();

//   await db.delete('MODELS', where: "MODEL_ID = ?", whereArgs: [modelId]);
// }
Future<void> deleteModel() async {
  // Get a reference to the database.
  final Database db = await openDb();
  await db.delete('MODELS', where: "TO_BE_DELETED = ?", whereArgs: [0]);
}

class Topic {
  int topicId;
  int modelId;
  String icon;
  String title;
  int toBeDeleted;

  Topic(this.topicId, this.modelId, this.icon, this.title, this.toBeDeleted);
  Map<String, dynamic> toMap() {
    return {
      'TOPIC_ID': topicId,
      'MODEL_ID': modelId,
      'TITLE': title,
      'ICON': icon,
      'TO_BE_DELETED': toBeDeleted
    };
  }
}

Future<void> insertTopic(Topic topic) async {
  final Database db = await openDb();
  await db.insert('TOPICS', topic.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace);
}

Future<List<Map>> getTopicsByModelId(modelId) async {
  // Get a reference to the database.
  final Database db = await openDb();

  // Query the table for all The Dogs.
  return await db.query('TOPICS', where: 'MODEL_ID= ?', whereArgs: [modelId]);
}

Future<List<Map>> getTopicByModelIdAndTopicId(modelId, topicId) async {
  // Get a reference to the database.
  final Database db = await openDb();

  // Query the table for all The Dogs.
  return await db.query('TOPICS',
      where: 'MODEL_ID= ? AND TOPIC_ID =?', whereArgs: [modelId, topicId]);
}

Future<void> updateTopic(Topic topic) async {
  // Get a reference to the database.
  final Database db = await openDb();
  await db.update('TOPICS', topic.toMap(),
      where: "MODEL_ID = ? AND TOPIC_ID = ?",
      whereArgs: [topic.modelId, topic.topicId]);
}

// Future<void> deleteTopic(int modelId, int topicId) async {
//   // Get a reference to the database.
//   final Database db = await openDb();

//   await db.delete('TOPICS',
//       where: "MODEL_ID = ? AND TOPIC_ID = ?", whereArgs: [modelId, topicId]);
// }
Future<void> deleteTopic() async {
  // Get a reference to the database.
  final Database db = await openDb();

  await db.delete('TOPICS', where: "TO_BE_DELETED = ?", whereArgs: [0]);
}

class Article {
  int articleId;
  int topicId;
  int modelId;
  String icon;
  String title;
  String updateDate;
  String createdDate;
  int viewed;
  int timesViewd;
  int timeSpendOnArticle;
  String dateViewed;
  int analyticsSaved;
  int toBeDeleted;

  Article(
      this.articleId,
      this.topicId,
      this.modelId,
      this.icon,
      this.title,
      this.updateDate,
      this.createdDate,
      this.viewed,
      this.timesViewd,
      this.timeSpendOnArticle,
      this.dateViewed,
      this.analyticsSaved,
      this.toBeDeleted);

  Map<String, dynamic> toMap() {
    return {
      'ARTICLE_ID': articleId,
      'TOPIC_ID': topicId,
      'MODEL_ID': modelId,
      'TITLE': title,
      'ICON': icon,
      'UPDATE_DATE': updateDate,
      'CREATED_DATE': createdDate,
      'VIEWED': viewed,
      'TIMES_VIEWED': timesViewd,
      'TIME_SPENT_ON_ARTICLE': timeSpendOnArticle,
      'DATE_VIEWED': dateViewed,
      'ANALYTICS_SAVED': analyticsSaved,
      'TO_BE_DELETED': toBeDeleted
    };
  }
}

Future<void> insertArticle(Article article) async {
  final Database db = await openDb();
  await db.insert('ATRICLES', article.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace);
}

Future<List<Map>> getArticlesByTopicIdAndModelId(modelId, topicId) async {
  // Get a reference to the database.
  final Database db = await openDb();

  // Query the table for all The Dogs.
  return await db.query('ATRICLES',
      where: 'MODEL_ID= ? AND  TOPIC_ID= ?', whereArgs: [modelId, topicId]);
}

Future<List<Map>> getArticleByIdAndByTopicIdAndModelId(
    modelId, topicId, articleId) async {
  // Get a reference to the database.
  final Database db = await openDb();

  // Query the table for all The Dogs.
  return await db.query('ATRICLES',
      where: 'MODEL_ID= ? AND  TOPIC_ID= ? AND ARTICLE_ID = ?',
      whereArgs: [modelId, topicId, articleId]);
}

Future<void> updateArticle(Map<String, dynamic> article) async {
  // Get a reference to the database.
  final Database db = await openDb();
  await db.update('ATRICLES', article,
      where: "MODEL_ID = ? AND TOPIC_ID = ? AND ARTICLE_ID = ?",
      whereArgs: [
        article["MODEL_ID"],
        article["TOPIC_ID"],
        article["ARTICLE_ID"]
      ]);
}

// Future<void> deleteArticle(int modelId, int topicId, int articleId) async {
//   // Get a reference to the database.
//   final Database db = await openDb();

//   await db.delete(
//     'ATRICLES',
//     where: "MODEL_ID = ? AND TOPIC_ID = ? AND ARTICLE_ID = ?",
//     whereArgs: [modelId, topicId, articleId]
//   );
// }
Future<void> deleteArticle() async {
  // Get a reference to the database.
  final Database db = await openDb();

  await db.delete('ATRICLES', where: "TO_BE_DELETED = ?", whereArgs: [0]);
}

class Content {
  int id; // memida id or text id
  int contentId;
  int articleId;
  int topicId;
  int modelId;
  String icon;
  String title;
  String contentDetails;
  String contentType;
  int contentOrder;
  int toBeDeleted;

  Content(
      this.id,
      this.contentId,
      this.articleId,
      this.topicId,
      this.modelId,
      this.contentDetails,
      this.contentType,
      this.contentOrder,
      this.toBeDeleted);

  Map<String, dynamic> toMap() {
    return {
      'ID': id,
      'CONTENT_ID': contentId,
      'ARTICLE_ID': articleId,
      'TOPIC_ID': topicId,
      'MODEL_ID': modelId,
      'CONTENT_DETIALS': contentDetails,
      'CONTENT_TYPE': contentType,
      'CONTENT_ORDER': contentOrder,
      'TO_BE_DELETED': toBeDeleted
    };
  }
}

Future<void> insertContent(Content content) async {
  final Database db = await openDb();
  await db.insert('CONTENT', content.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace);
}

Future<List<Map>> getContentByArticleId(modelId, topicId, articleId) async {
  // Get a reference to the database.
  final Database db = await openDb();

  // Query the table for all The Dogs.
  return await db.query('CONTENT',
      where: 'MODEL_ID= ? AND  TOPIC_ID= ? AND ARTICLE_ID= ?',
      orderBy: 'CONTENT_ORDER ASC',
      whereArgs: [modelId, topicId, articleId]);
}

Future<List<Map>> getContentById(
    modelId, topicId, articleId, contentId, id) async {
  // Get a reference to the database.
  final Database db = await openDb();

  // Query the table for all The Dogs.
  return await db.query('CONTENT',
      where:
          'MODEL_ID= ? AND  TOPIC_ID= ? AND ARTICLE_ID= ? AND CONTENT_ID = ? AND ID =?',
      whereArgs: [modelId, topicId, articleId, contentId, id]);
}

Future<void> updateContent(Content content) async {
  // Get a reference to the database.
  final Database db = await openDb();
  await db.update(
    'CONTENT',
    content.toMap(),
    where:
        "MODEL_ID = ? AND TOPIC_ID = ? AND ARTICLE_ID = ? AND CONTENT_ID = ? AND ID = ?",
    whereArgs: [
      content.modelId,
      content.topicId,
      content.articleId,
      content.contentId,
      content.id
    ],
  );
}

Future<void> deleteContent() async {
  // Get a reference to the database.
  final Database db = await openDb();
  await db.delete('CONTENT', where: "TO_BE_DELETED = ?", whereArgs: [0]);
}

Future<void> updateAllToBeDeleted() async {
  final Database db = await openDb();
  await db.update(
    'CONTENT',
    {"TO_BE_DELETED": 0},
    where: "TO_BE_DELETED = ?",
    whereArgs: [1],
  );
  await db.update(
    'ATRICLES',
    {"TO_BE_DELETED": 0},
    where: "TO_BE_DELETED = ?",
    whereArgs: [1],
  );
  await db.update(
    'TOPICS',
    {"TO_BE_DELETED": 0},
    where: "TO_BE_DELETED = ?",
    whereArgs: [1],
  );
  await db.update(
    'MODELS',
    {"TO_BE_DELETED": 0},
    where: "TO_BE_DELETED = ?",
    whereArgs: [1],
  );
}

// progress related functions

Future<int> getOverallNumOfArticles() async {
  final Database db = await openDb();

  return Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM ATRICLES'));
}

Future<int> getOverallNumOfViewedArticles() async {
  final Database db = await openDb();
  return Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM ATRICLES WHERE VIEWED = 1'));
}

Future<int> getOverallNumOfArticlesOfAModel(int modelId) async {
  final Database db = await openDb();

  return Sqflite.firstIntValue(await db
      .rawQuery('SELECT COUNT(*) FROM ATRICLES WHERE MODEL_ID =$modelId'));
}

Future<int> getOverallNumOfViewedArticlesOfAModel(int modelId) async {
  final Database db = await openDb();
  return Sqflite.firstIntValue(await db.rawQuery(
      'SELECT COUNT(*) FROM ATRICLES WHERE MODEL_ID =$modelId AND VIEWED = 1'));
}

Future<bool> getIfArticleViewedDb(modelId, topciId, articleId) async {
  final Database db = await openDb();
  int count = Sqflite.firstIntValue(await db.rawQuery(
      'SELECT COUNT(*) FROM ATRICLES WHERE MODEL_ID =$modelId AND TOPIC_ID = $topciId AND ARTICLE_ID=$articleId  AND VIEWED = 1'));
  return count > 0;
}

Future<bool> getIfAllArticlesViewedOfAtopicDb(modelId, topciId) async {
  final Database db = await openDb();
  int allArticles = Sqflite.firstIntValue(await db.rawQuery(
      'SELECT COUNT(*) FROM ATRICLES WHERE MODEL_ID =$modelId  AND TOPIC_ID = $topciId'));
  int count = Sqflite.firstIntValue(await db.rawQuery(
      'SELECT COUNT(*) FROM ATRICLES WHERE MODEL_ID =$modelId  AND TOPIC_ID = $topciId AND VIEWED = 1'));
  return allArticles == count;
}

Future<void> setArticleCompleted(modelId, topicId, articleId) async {
  final Database db = await openDb();
  var now = (new DateTime.now()).toString();

  await db.rawQuery('UPDATE ATRICLES SET VIEWED = 1,TIMES_VIEWED = (' +
      '(SELECT TIMES_VIEWED FROM ATRICLES  WHERE MODEL_ID =$modelId  AND TOPIC_ID = ' +
      '$topicId AND ARTICLE_ID =$articleId) + 1 ), ANALYTICS_SAVED = 0, DATE_VIEWED = "$now" WHERE MODEL_ID =$modelId  AND TOPIC_ID = $topicId AND ARTICLE_ID =$articleId');
}

Future<void> saveDurationDb(modelId, topicId, articleId, duration) async {
  final Database db = await openDb();
  await db.rawQuery(
      'UPDATE ATRICLES SET TIME_SPENT_ON_ARTICLE = $duration ,TIMES_VIEWED = (' +
          '(SELECT TIMES_VIEWED FROM ATRICLES  WHERE MODEL_ID =$modelId  AND TOPIC_ID = ' +
          '$topicId AND ARTICLE_ID =$articleId) + 1 ), ANALYTICS_SAVED = 0 WHERE MODEL_ID =$modelId  AND TOPIC_ID = $topicId AND ARTICLE_ID =$articleId');
}

Future<List> getArticlesAnalyticsFromDb() async {
  final Database db = await openDb();
  List allArticles =
      await db.rawQuery('SELECT * FROM ATRICLES WHERE ANALYTICS_SAVED =0');
  return allArticles;
}

Future<void> setAllUnsavedAnalyticsIntoSaved() async {
  final Database db = await openDb();
  await db.rawQuery(
      'UPDATE ATRICLES SET ANALYTICS_SAVED = 1 WHERE ANALYTICS_SAVED = 0 ');
}
