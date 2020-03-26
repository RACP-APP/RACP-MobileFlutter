import 'package:mobx/mobx.dart';

part 'module_page_store.g.dart';

class PageStore = _PageStore with _$PageStore;

abstract class _PageStore with Store {
  @observable
  bool completed = false;

  @observable
  bool options = false;

  @observable
  List pageNum = [
    {
      "text": [
        {"ContentText": "Introduction", "MediaType": "Text"}
      ],
      "Media": []
    }
  ];

  @observable
  bool last = false;

  @observable
  bool next = false;

  @computed
  bool get getOptions => options;

  @computed
  bool get getCompletion => completed;

  @computed
  List get getPage => pageNum;
  @computed
  bool get getLast => last;

  @computed
  bool get getNext => next;

  @action
  void setCompletion(bool v) {
    completed = v;
  }

  @action
  void setOptions(bool v) {
    options = v;
  }

  @action
  void setPage(List v) {
    pageNum = v;
  }

  @action
  void setLast(bool v) {
    last = v;
  }

  @action
  void setNext(bool v) {
    next = v;
  }
}
