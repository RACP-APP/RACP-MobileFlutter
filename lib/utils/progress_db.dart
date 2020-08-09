import '../utils/db.dart';

Future<double> getOverallProgressPercent() async {
  if ( await getOverallNumOfArticles() != 0) {
  return await getOverallNumOfViewedArticles() / await getOverallNumOfArticles();
  } 
  return 0;
}

Future<double> getModelProgressPercent(modelId) async {
if ( await getOverallNumOfArticlesOfAModel(modelId) != 0) {
  return (await getOverallNumOfViewedArticlesOfAModel(modelId)/await getOverallNumOfArticlesOfAModel(modelId));
  } 
  return 0;
}

Future<bool> getIfArticleViewed(modelId, topciId, articleId) async {
  return await getIfArticleViewedDb(modelId, topciId, articleId);
}

Future<bool> getIfAllArticlesViewedOfAtopic(modelId, topciId) async {
  return await getIfAllArticlesViewedOfAtopicDb(modelId, topciId);
}

