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

  @computed
  String get getCurrent => current;

  @computed
  bool get getOptions => options;

  @computed
  bool get getCompletion => completed;

  @action
  void setCurrent(String v) {
    current = v;
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
