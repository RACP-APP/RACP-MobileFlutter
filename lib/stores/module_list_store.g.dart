// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'module_list_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ListStore on _ListStore, Store {
  final _$enrollViewAtom = Atom(name: '_ListStore.enrollView');

  @override
  List<dynamic> get enrollView {
    _$enrollViewAtom.context.enforceReadPolicy(_$enrollViewAtom);
    _$enrollViewAtom.reportObserved();
    return super.enrollView;
  }

  @override
  set enrollView(List<dynamic> value) {
    _$enrollViewAtom.context.conditionallyRunInAction(() {
      super.enrollView = value;
      _$enrollViewAtom.reportChanged();
    }, _$enrollViewAtom, name: '${_$enrollViewAtom.name}_set');
  }

  final _$globalViewAtom = Atom(name: '_ListStore.globalView');

  @override
  List<dynamic> get globalView {
    _$globalViewAtom.context.enforceReadPolicy(_$globalViewAtom);
    _$globalViewAtom.reportObserved();
    return super.globalView;
  }

  @override
  set globalView(List<dynamic> value) {
    _$globalViewAtom.context.conditionallyRunInAction(() {
      super.globalView = value;
      _$globalViewAtom.reportChanged();
    }, _$globalViewAtom, name: '${_$globalViewAtom.name}_set');
  }

  final _$bookViewPropsAtom = Atom(name: '_ListStore.bookViewProps');

  @override
  List<dynamic> get bookViewProps {
    _$bookViewPropsAtom.context.enforceReadPolicy(_$bookViewPropsAtom);
    _$bookViewPropsAtom.reportObserved();
    return super.bookViewProps;
  }

  @override
  set bookViewProps(List<dynamic> value) {
    _$bookViewPropsAtom.context.conditionallyRunInAction(() {
      super.bookViewProps = value;
      _$bookViewPropsAtom.reportChanged();
    }, _$bookViewPropsAtom, name: '${_$bookViewPropsAtom.name}_set');
  }

  final _$_ListStoreActionController = ActionController(name: '_ListStore');

  @override
  void setEnroll(List<dynamic> v) {
    final _$actionInfo = _$_ListStoreActionController.startAction();
    try {
      return super.setEnroll(v);
    } finally {
      _$_ListStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setGlobal(List<dynamic> v) {
    final _$actionInfo = _$_ListStoreActionController.startAction();
    try {
      return super.setGlobal(v);
    } finally {
      _$_ListStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setBook(List<dynamic> v) {
    final _$actionInfo = _$_ListStoreActionController.startAction();
    try {
      return super.setBook(v);
    } finally {
      _$_ListStoreActionController.endAction(_$actionInfo);
    }
  }
}
