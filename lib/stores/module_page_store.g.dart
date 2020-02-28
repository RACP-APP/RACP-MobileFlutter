// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'module_page_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PageStore on _PageStore, Store {
  Computed<bool> _$getOptionsComputed;

  @override
  bool get getOptions =>
      (_$getOptionsComputed ??= Computed<bool>(() => super.getOptions)).value;
  Computed<bool> _$getCompletionComputed;

  @override
  bool get getCompletion =>
      (_$getCompletionComputed ??= Computed<bool>(() => super.getCompletion))
          .value;
  Computed<List<dynamic>> _$getPageComputed;

  @override
  List<dynamic> get getPage =>
      (_$getPageComputed ??= Computed<List<dynamic>>(() => super.getPage))
          .value;
  Computed<bool> _$getLastComputed;

  @override
  bool get getLast =>
      (_$getLastComputed ??= Computed<bool>(() => super.getLast)).value;
  Computed<bool> _$getNextComputed;

  @override
  bool get getNext =>
      (_$getNextComputed ??= Computed<bool>(() => super.getNext)).value;

  final _$completedAtom = Atom(name: '_PageStore.completed');

  @override
  bool get completed {
    _$completedAtom.context.enforceReadPolicy(_$completedAtom);
    _$completedAtom.reportObserved();
    return super.completed;
  }

  @override
  set completed(bool value) {
    _$completedAtom.context.conditionallyRunInAction(() {
      super.completed = value;
      _$completedAtom.reportChanged();
    }, _$completedAtom, name: '${_$completedAtom.name}_set');
  }

  final _$optionsAtom = Atom(name: '_PageStore.options');

  @override
  bool get options {
    _$optionsAtom.context.enforceReadPolicy(_$optionsAtom);
    _$optionsAtom.reportObserved();
    return super.options;
  }

  @override
  set options(bool value) {
    _$optionsAtom.context.conditionallyRunInAction(() {
      super.options = value;
      _$optionsAtom.reportChanged();
    }, _$optionsAtom, name: '${_$optionsAtom.name}_set');
  }

  final _$pageNumAtom = Atom(name: '_PageStore.pageNum');

  @override
  List<dynamic> get pageNum {
    _$pageNumAtom.context.enforceReadPolicy(_$pageNumAtom);
    _$pageNumAtom.reportObserved();
    return super.pageNum;
  }

  @override
  set pageNum(List<dynamic> value) {
    _$pageNumAtom.context.conditionallyRunInAction(() {
      super.pageNum = value;
      _$pageNumAtom.reportChanged();
    }, _$pageNumAtom, name: '${_$pageNumAtom.name}_set');
  }

  final _$lastAtom = Atom(name: '_PageStore.last');

  @override
  bool get last {
    _$lastAtom.context.enforceReadPolicy(_$lastAtom);
    _$lastAtom.reportObserved();
    return super.last;
  }

  @override
  set last(bool value) {
    _$lastAtom.context.conditionallyRunInAction(() {
      super.last = value;
      _$lastAtom.reportChanged();
    }, _$lastAtom, name: '${_$lastAtom.name}_set');
  }

  final _$nextAtom = Atom(name: '_PageStore.next');

  @override
  bool get next {
    _$nextAtom.context.enforceReadPolicy(_$nextAtom);
    _$nextAtom.reportObserved();
    return super.next;
  }

  @override
  set next(bool value) {
    _$nextAtom.context.conditionallyRunInAction(() {
      super.next = value;
      _$nextAtom.reportChanged();
    }, _$nextAtom, name: '${_$nextAtom.name}_set');
  }

  final _$_PageStoreActionController = ActionController(name: '_PageStore');

  @override
  void setCompletion(bool v) {
    final _$actionInfo = _$_PageStoreActionController.startAction();
    try {
      return super.setCompletion(v);
    } finally {
      _$_PageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setOptions(bool v) {
    final _$actionInfo = _$_PageStoreActionController.startAction();
    try {
      return super.setOptions(v);
    } finally {
      _$_PageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPage(List<dynamic> v) {
    final _$actionInfo = _$_PageStoreActionController.startAction();
    try {
      return super.setPage(v);
    } finally {
      _$_PageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLast(bool v) {
    final _$actionInfo = _$_PageStoreActionController.startAction();
    try {
      return super.setLast(v);
    } finally {
      _$_PageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNext(bool v) {
    final _$actionInfo = _$_PageStoreActionController.startAction();
    try {
      return super.setNext(v);
    } finally {
      _$_PageStoreActionController.endAction(_$actionInfo);
    }
  }
}
