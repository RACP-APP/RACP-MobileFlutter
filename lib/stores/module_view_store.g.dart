// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'module_view_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ViewStore on _ViewStore, Store {
  Computed<String> _$getNameComputed;

  @override
  String get getName =>
      (_$getNameComputed ??= Computed<String>(() => super.getName)).value;

  final _$moduleNameAtom = Atom(name: '_ViewStore.moduleName');

  @override
  String get moduleName {
    _$moduleNameAtom.context.enforceReadPolicy(_$moduleNameAtom);
    _$moduleNameAtom.reportObserved();
    return super.moduleName;
  }

  @override
  set moduleName(String value) {
    _$moduleNameAtom.context.conditionallyRunInAction(() {
      super.moduleName = value;
      _$moduleNameAtom.reportChanged();
    }, _$moduleNameAtom, name: '${_$moduleNameAtom.name}_set');
  }

  final _$_ViewStoreActionController = ActionController(name: '_ViewStore');

  @override
  void setCurrentName(String name) {
    final _$actionInfo = _$_ViewStoreActionController.startAction();
    try {
      return super.setCurrentName(name);
    } finally {
      _$_ViewStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'moduleName: ${moduleName.toString()},getName: ${getName.toString()}';
    return '{$string}';
  }
}
