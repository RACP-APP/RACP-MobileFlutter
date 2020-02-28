// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_handler_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$VideoStore on _VideoStore, Store {
  Computed<bool> _$getDoneComputed;

  @override
  bool get getDone =>
      (_$getDoneComputed ??= Computed<bool>(() => super.getDone)).value;
  Computed<bool> _$getStreamComputed;

  @override
  bool get getStream =>
      (_$getStreamComputed ??= Computed<bool>(() => super.getStream)).value;

  final _$doneAtom = Atom(name: '_VideoStore.done');

  @override
  bool get done {
    _$doneAtom.context.enforceReadPolicy(_$doneAtom);
    _$doneAtom.reportObserved();
    return super.done;
  }

  @override
  set done(bool value) {
    _$doneAtom.context.conditionallyRunInAction(() {
      super.done = value;
      _$doneAtom.reportChanged();
    }, _$doneAtom, name: '${_$doneAtom.name}_set');
  }

  final _$streamAtom = Atom(name: '_VideoStore.stream');

  @override
  bool get stream {
    _$streamAtom.context.enforceReadPolicy(_$streamAtom);
    _$streamAtom.reportObserved();
    return super.stream;
  }

  @override
  set stream(bool value) {
    _$streamAtom.context.conditionallyRunInAction(() {
      super.stream = value;
      _$streamAtom.reportChanged();
    }, _$streamAtom, name: '${_$streamAtom.name}_set');
  }

  final _$_VideoStoreActionController = ActionController(name: '_VideoStore');

  @override
  void setDone() {
    final _$actionInfo = _$_VideoStoreActionController.startAction();
    try {
      return super.setDone();
    } finally {
      _$_VideoStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setStream(dynamic v) {
    final _$actionInfo = _$_VideoStoreActionController.startAction();
    try {
      return super.setStream(v);
    } finally {
      _$_VideoStoreActionController.endAction(_$actionInfo);
    }
  }
}
