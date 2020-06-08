// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProgressStore on _ProgressStore, Store {
  Computed<double> _$getProgressComputed;

  @override
  double get getProgress =>
      (_$getProgressComputed ??= Computed<double>(() => super.getProgress))
          .value;
  Computed<double> _$getOverAllProgressComputed;

  @override
  double get getOverAllProgress => (_$getOverAllProgressComputed ??=
          Computed<double>(() => super.getOverAllProgress))
      .value;
  Computed<Map<int, double>> _$getModuleProgressComputed;

  @override
  Map<int, double> get getModuleProgress => (_$getModuleProgressComputed ??=
          Computed<Map<int, double>>(() => super.getModuleProgress))
      .value;

  final _$progressAtom = Atom(name: '_ProgressStore.progress');

  @override
  double get progress {
    _$progressAtom.context.enforceReadPolicy(_$progressAtom);
    _$progressAtom.reportObserved();
    return super.progress;
  }

  @override
  set progress(double value) {
    _$progressAtom.context.conditionallyRunInAction(() {
      super.progress = value;
      _$progressAtom.reportChanged();
    }, _$progressAtom, name: '${_$progressAtom.name}_set');
  }

  final _$overAllProgressAtom = Atom(name: '_ProgressStore.overAllProgress');

  @override
  double get overAllProgress {
    _$overAllProgressAtom.context.enforceReadPolicy(_$overAllProgressAtom);
    _$overAllProgressAtom.reportObserved();
    return super.overAllProgress;
  }

  @override
  set overAllProgress(double value) {
    _$overAllProgressAtom.context.conditionallyRunInAction(() {
      super.overAllProgress = value;
      _$overAllProgressAtom.reportChanged();
    }, _$overAllProgressAtom, name: '${_$overAllProgressAtom.name}_set');
  }

  final _$moudleProgressAtom = Atom(name: '_ProgressStore.moudleProgress');

  @override
  Map<int, double> get moudleProgress {
    _$moudleProgressAtom.context.enforceReadPolicy(_$moudleProgressAtom);
    _$moudleProgressAtom.reportObserved();
    return super.moudleProgress;
  }

  @override
  set moudleProgress(Map<int, double> value) {
    _$moudleProgressAtom.context.conditionallyRunInAction(() {
      super.moudleProgress = value;
      _$moudleProgressAtom.reportChanged();
    }, _$moudleProgressAtom, name: '${_$moudleProgressAtom.name}_set');
  }

  final _$_ProgressStoreActionController =
      ActionController(name: '_ProgressStore');

  @override
  void setProgress(double p) {
    final _$actionInfo = _$_ProgressStoreActionController.startAction();
    try {
      return super.setProgress(p);
    } finally {
      _$_ProgressStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setOverAllProgress(double p) {
    final _$actionInfo = _$_ProgressStoreActionController.startAction();
    try {
      return super.setOverAllProgress(p);
    } finally {
      _$_ProgressStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setModuleProgress(int modId, double p) {
    final _$actionInfo = _$_ProgressStoreActionController.startAction();
    try {
      return super.setModuleProgress(modId, p);
    } finally {
      _$_ProgressStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'progress: ${progress.toString()},overAllProgress: ${overAllProgress.toString()},moudleProgress: ${moudleProgress.toString()},getProgress: ${getProgress.toString()},getOverAllProgress: ${getOverAllProgress.toString()},getModuleProgress: ${getModuleProgress.toString()}';
    return '{$string}';
  }
}
