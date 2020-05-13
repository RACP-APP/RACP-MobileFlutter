import 'package:mobx/mobx.dart';

part 'module_page_store.g.dart';

class PageStore = _PageStore with _$PageStore;

abstract class _PageStore with Store {
  @observable
  bool completed = false;

  @observable
  bool options = false;

  @observable
  double progress = 0.0;

  @observable
  List audioFiles = new List();

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
  double get getProgress => progress;

  @computed
  List get getAudioFiles => audioFiles;

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
  void setProgress(double p) {
    progress = p ;
  }

  @action
  void setAudioFiles(List a) {
    audioFiles = a ;
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
