import 'package:mobx/mobx.dart';

part 'drawer_store.g.dart';

class DrawerStore = _DrawerStore with _$DrawerStore;

abstract class _DrawerStore with Store {
  @observable
  String current = "";

  @observable
  bool options = false;

  @observable
  bool completed = false;

  @observable
  Map articles = new Map<int, dynamic>();

  @observable
  Map topics = new Map<int, bool>();

  @computed
  String get getCurrent => current;

  @computed
  bool get getOptions => options;

  @computed
  bool get getCompletion => completed;

  @computed
  bool getArticleState(topicId, articleId) {
    var articleState = false;
    if (articles[topicId] == null) {
      return false;
    } else {
      articles[topicId].forEach((article) {
        article.forEach((key, value) {
          if (key == articleId) {
            articleState = value;
          }
        });
      });
      return articleState;
    }
  }

  @computed
  bool getTopicState(topicId) {
    var topicState = true;
    if (articles[topicId] == null) {
      return false;
    } else {
      print('llllllllllllllllllllllllSlllllllllll');
      print(articles[topicId].length);
      articles[topicId].forEach((article) {
        article.forEach((key, value) {
          print('ehlllllllllllllllllllllllllllllllllll');
          print(value);
          topicState = topicState && value;
       
          print(topicState);
        });
      });
       topics[topicId] = topicState;
      return topics[topicId];
    }
  }

  @computed
  bool getIfArticlesExist(topicId) {
    print('-----getting if articles of a topic exists ---------------');
    if (articles[topicId] == null || articles[topicId] == [] ) {
      return false;
    } else {
      return true;
    }
  }
  @action
  void setCurrent(String v) {
    current = v;
  }

  @action
  void setArticleState(int topicId, int articleId, bool v) {
    if (articles[topicId] == null || articles[topicId] == []) {
      articles[topicId] = new List<Map<int, bool>>();
      articles[topicId].add({articleId: v});
    } else {
      bool articleExists = false;
      articles[topicId].forEach((article) {
        article.forEach((key, value) {
          if (key == articleId) {
            articleExists = true;
          }
        });
      });
      if (!articleExists) {
        articles[topicId].add({articleId: v});
      } else {
        articles[topicId].forEach((article) {
          article.forEach((key, value) {
            if (key == articleId) {
              article[articleId] = v;
            }
          });
        });
      }
    }
  }

  @action
  void setTopicState(int topicId) {
    print('33333333 setting topic {$topicId} state 3333333333333333333');
    bool topicState = getTopicState(topicId);
    topics[topicId] = topicState;
  }

  @action
  void setOptions(bool v) {
    options = v;
  }

  @action
  void setCompletion(bool v) {
    completed = v;
  }
}
