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
  Map articles = new Map<int,bool>();
  @observable
  Map topics = new Map<String,bool>();
   
  @computed
  String get getCurrent => current;

  @computed
  bool get getOptions => options;

  @computed
  bool get getCompletion => completed;

  @computed
  bool  getArticleState(articleId) => articles[articleId];

  @action
  void setCurrent(String v) {
    current = v;
  }

  @action
  void setArticleState(int articleId,bool v) {
    articles[articleId] = v;
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
