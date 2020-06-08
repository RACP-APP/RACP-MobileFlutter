import 'package:mobx/mobx.dart';

part 'progress_store.g.dart';

class ProgressStore = _ProgressStore with _$ProgressStore;

abstract class _ProgressStore with Store {
  @observable
  double progress = 0.0; // in the module page view

  @observable
  double overAllProgress = 0.0;

  @observable
  Map<int, double> moudleProgress = new Map<int, double>();

  @computed
  double get getProgress => progress;

  @computed
  double get getOverAllProgress => overAllProgress;

  @computed
  Map<int, double> get getModuleProgress => moudleProgress;

  @action
  void setProgress(double p) {
    progress = p;
  }

  @action
  void setOverAllProgress(double p) {
    overAllProgress = p;
  }

  @action
  void setModuleProgress(int modId, double p) {
    moudleProgress[modId] = p;
  }
}
