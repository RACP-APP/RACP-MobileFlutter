import 'package:mobx/mobx.dart';

part 'module_view_store.g.dart';

class ViewStore = _ViewStore with _$ViewStore;

abstract class _ViewStore with Store {
  @observable
  String moduleName = "";
  @computed
  String get getName => moduleName;

  @action
  void setCurrentName(String name) {
    moduleName = name;
  }
}
