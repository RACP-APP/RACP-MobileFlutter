import 'package:mobx/mobx.dart';

part 'progress_store.g.dart';

class ProgressStore = _ProgressStore with _$ProgressStore;

abstract class _ProgressStore with Store {
  @observable
  double progress = 0.0 ;
  @computed
  double get getProgress => progress;

  @action
  void setProgress(double p) {
    progress = p;
  }
}
