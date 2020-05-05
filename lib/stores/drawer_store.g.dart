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
  Computed<Map<dynamic, dynamic>> _$getTopicsComputed;

  @override
  Map<dynamic, dynamic> get getTopics => (_$getTopicsComputed ??=
          Computed<Map<dynamic, dynamic>>(() => super.getTopics))
      .value;
  Computed<Map<dynamic, dynamic>> _$getArticlesComputed;

  @override
  Map<dynamic, dynamic> get getArticles => (_$getArticlesComputed ??=
          Computed<Map<dynamic, dynamic>>(() => super.getArticles))
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

  final _$articlesAtom = Atom(name: '_DrawerStore.articles');

  @override
  Map<dynamic, dynamic> get articles {
    _$articlesAtom.context.enforceReadPolicy(_$articlesAtom);
    _$articlesAtom.reportObserved();
    return super.articles;
  }

  @override
  set articles(Map<dynamic, dynamic> value) {
    _$articlesAtom.context.conditionallyRunInAction(() {
      super.articles = value;
      _$articlesAtom.reportChanged();
    }, _$articlesAtom, name: '${_$articlesAtom.name}_set');
  }

  final _$topicsAtom = Atom(name: '_DrawerStore.topics');

  @override
  Map<dynamic, dynamic> get topics {
    _$topicsAtom.context.enforceReadPolicy(_$topicsAtom);
    _$topicsAtom.reportObserved();
    return super.topics;
  }

  @override
  set topics(Map<dynamic, dynamic> value) {
    _$topicsAtom.context.conditionallyRunInAction(() {
      super.topics = value;
      _$topicsAtom.reportChanged();
    }, _$topicsAtom, name: '${_$topicsAtom.name}_set');
  }

  final _$_DrawerStoreActionController = ActionController(name: '_DrawerStore');

  @override
  bool getArticleState(dynamic topicId, dynamic articleId) {
    final _$actionInfo = _$_DrawerStoreActionController.startAction();
    try {
      return super.getArticleState(topicId, articleId);
    } finally {
      _$_DrawerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  bool getTopicState(dynamic topicId) {
    final _$actionInfo = _$_DrawerStoreActionController.startAction();
    try {
      return super.getTopicState(topicId);
    } finally {
      _$_DrawerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  bool getIfArticlesExist(dynamic topicId) {
    final _$actionInfo = _$_DrawerStoreActionController.startAction();
    try {
      return super.getIfArticlesExist(topicId);
    } finally {
      _$_DrawerStoreActionController.endAction(_$actionInfo);
    }
  }

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
  void setArticleState(int topicId, int articleId, bool v) {
    final _$actionInfo = _$_DrawerStoreActionController.startAction();
    try {
      return super.setArticleState(topicId, articleId, v);
    } finally {
      _$_DrawerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTopicState(int topicId) {
    final _$actionInfo = _$_DrawerStoreActionController.startAction();
    try {
      return super.setTopicState(topicId);
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
  void setArticles(Map<dynamic, dynamic> v) {
    final _$actionInfo = _$_DrawerStoreActionController.startAction();
    try {
      return super.setArticles(v);
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
        'current: ${current.toString()},options: ${options.toString()},completed: ${completed.toString()},articles: ${articles.toString()},topics: ${topics.toString()},getCurrent: ${getCurrent.toString()},getOptions: ${getOptions.toString()},getCompletion: ${getCompletion.toString()},getTopics: ${getTopics.toString()},getArticles: ${getArticles.toString()}';
    return '{$string}';
  }
}
