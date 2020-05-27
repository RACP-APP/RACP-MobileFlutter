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
  String toString() {
    final string =
        'progress: ${progress.toString()},getProgress: ${getProgress.toString()}';
    return '{$string}';
  }
}
