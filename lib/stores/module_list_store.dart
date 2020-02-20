import 'package:mobx/mobx.dart';

part 'module_list_store.g.dart';

class ListStore = _ListStore with _$ListStore;

abstract class _ListStore with Store {
  // Store varibales "States"
  @observable
  List enrollView = [];
  @observable
  List globalView = [];
  @observable
  List bookViewProps = [];

  @action
  void setEnroll(List v) {
    enrollView = v;
  }

  @action
  void setGlobal(List v) {
    globalView = v;
  }

  @action
  void setBook(List v) {
    bookViewProps = v;
  }
}
