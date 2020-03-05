// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drawer_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DrawerStore on _DrawerStore, Store {
  Computed<String> _$getCurrentComputed;

  @override
  String get getCurrent =>
      (_$getCurrentComputed ??= Computed<String>(() => super.getCurrent)).value;
  Computed<bool> _$getOptionsComputed;

  @override
  bool get getOptions =>
      (_$getOptionsComputed ??= Computed<bool>(() => super.getOptions)).value;
  Computed<bool> _$getCompletionComputed;

  @override
  bool get getCompletion =>
      (_$getCompletionComputed ??= Computed<bool>(() => super.getCompletion))
          .value;

  final _$currentAtom = Atom(name: '_DrawerStore.current');

  @override
  String get current {
    _$currentAtom.context.enforceReadPolicy(_$currentAtom);
    _$currentAtom.reportObserved();
    return super.current;
  }

  @override
  set current(String value) {
    _$currentAtom.context.conditionallyRunInAction(() {
      super.current = value;
      _$currentAtom.reportChanged();
    }, _$currentAtom, name: '${_$currentAtom.name}_set');
  }

  final _$optionsAtom = Atom(name: '_DrawerStore.options');

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

  final _$completedAtom = Atom(name: '_DrawerStore.completed');

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

  final _$_DrawerStoreActionController = ActionController(name: '_DrawerStore');

  @override
  void setCurrent(String v) {
    final _$actionInfo = _$_DrawerStoreActionController.startAction();
    try {
      return super.setCurrent(v);
    } finally {
      _$_DrawerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setOptions(bool v) {
    final _$actionInfo = _$_DrawerStoreActionController.startAction();
    try {
      return super.setOptions(v);
    } finally {
      _$_DrawerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCompletion(bool v) {
    final _$actionInfo = _$_DrawerStoreActionController.startAction();
    try {
      return super.setCompletion(v);
    } finally {
      _$_DrawerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'current: ${current.toString()},options: ${options.toString()},completed: ${completed.toString()},getCurrent: ${getCurrent.toString()},getOptions: ${getOptions.toString()},getCompletion: ${getCompletion.toString()}';
    return '{$string}';
  }
}
