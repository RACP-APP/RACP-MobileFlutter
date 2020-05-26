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
  Computed<double> _$getProgressComputed;

  @override
  double get getProgress =>
      (_$getProgressComputed ??= Computed<double>(() => super.getProgress))
          .value;
  Computed<List<dynamic>> _$getAudioFilesComputed;

  @override
  List<dynamic> get getAudioFiles => (_$getAudioFilesComputed ??=
          Computed<List<dynamic>>(() => super.getAudioFiles))
      .value;
  Computed<bool> _$getCompletionComputed;

  @override
  bool get getCompletion =>
      (_$getCompletionComputed ??= Computed<bool>(() => super.getCompletion))
          .value;
  Computed<List<dynamic>> _$getContentComputed;

  @override
  List<dynamic> get getContent =>
      (_$getContentComputed ??= Computed<List<dynamic>>(() => super.getContent))
          .value;
  Computed<bool> _$getLastComputed;

  @override
  bool get getLast =>
      (_$getLastComputed ??= Computed<bool>(() => super.getLast)).value;
  Computed<bool> _$getNextComputed;

  @override
  bool get getNext =>
      (_$getNextComputed ??= Computed<bool>(() => super.getNext)).value;
  Computed<int> _$getArticleIdComputed;

  @override
  int get getArticleId =>
      (_$getArticleIdComputed ??= Computed<int>(() => super.getArticleId))
          .value;
  Computed<int> _$getTopicIdComputed;

  @override
  int get getTopicId =>
      (_$getTopicIdComputed ??= Computed<int>(() => super.getTopicId)).value;

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

  final _$progressAtom = Atom(name: '_PageStore.progress');

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

  final _$topicIdAtom = Atom(name: '_PageStore.topicId');

  @override
  int get topicId {
    _$topicIdAtom.context.enforceReadPolicy(_$topicIdAtom);
    _$topicIdAtom.reportObserved();
    return super.topicId;
  }

  @override
  set topicId(int value) {
    _$topicIdAtom.context.conditionallyRunInAction(() {
      super.topicId = value;
      _$topicIdAtom.reportChanged();
    }, _$topicIdAtom, name: '${_$topicIdAtom.name}_set');
  }

  final _$articleIdAtom = Atom(name: '_PageStore.articleId');

  @override
  int get articleId {
    _$articleIdAtom.context.enforceReadPolicy(_$articleIdAtom);
    _$articleIdAtom.reportObserved();
    return super.articleId;
  }

  @override
  set articleId(int value) {
    _$articleIdAtom.context.conditionallyRunInAction(() {
      super.articleId = value;
      _$articleIdAtom.reportChanged();
    }, _$articleIdAtom, name: '${_$articleIdAtom.name}_set');
  }

  final _$audioFilesAtom = Atom(name: '_PageStore.audioFiles');

  @override
  List<dynamic> get audioFiles {
    _$audioFilesAtom.context.enforceReadPolicy(_$audioFilesAtom);
    _$audioFilesAtom.reportObserved();
    return super.audioFiles;
  }

  @override
  set audioFiles(List<dynamic> value) {
    _$audioFilesAtom.context.conditionallyRunInAction(() {
      super.audioFiles = value;
      _$audioFilesAtom.reportChanged();
    }, _$audioFilesAtom, name: '${_$audioFilesAtom.name}_set');
  }

  final _$contentAtom = Atom(name: '_PageStore.content');

  @override
  List<dynamic> get content {
    _$contentAtom.context.enforceReadPolicy(_$contentAtom);
    _$contentAtom.reportObserved();
    return super.content;
  }

  @override
  set content(List<dynamic> value) {
    _$contentAtom.context.conditionallyRunInAction(() {
      super.content = value;
      _$contentAtom.reportChanged();
    }, _$contentAtom, name: '${_$contentAtom.name}_set');
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
  void setProgress(double p) {
    final _$actionInfo = _$_PageStoreActionController.startAction();
    try {
      return super.setProgress(p);
    } finally {
      _$_PageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAudioFiles(List<dynamic> a) {
    final _$actionInfo = _$_PageStoreActionController.startAction();
    try {
      return super.setAudioFiles(a);
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
  void setContent(List<dynamic> v) {
    final _$actionInfo = _$_PageStoreActionController.startAction();
    try {
      return super.setContent(v);
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

  @override
  void setArticleId(int v) {
    final _$actionInfo = _$_PageStoreActionController.startAction();
    try {
      return super.setArticleId(v);
    } finally {
      _$_PageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTopicId(int v) {
    final _$actionInfo = _$_PageStoreActionController.startAction();
    try {
      return super.setTopicId(v);
    } finally {
      _$_PageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'completed: ${completed.toString()},options: ${options.toString()},progress: ${progress.toString()},topicId: ${topicId.toString()},articleId: ${articleId.toString()},audioFiles: ${audioFiles.toString()},content: ${content.toString()},last: ${last.toString()},next: ${next.toString()},getOptions: ${getOptions.toString()},getProgress: ${getProgress.toString()},getAudioFiles: ${getAudioFiles.toString()},getCompletion: ${getCompletion.toString()},getContent: ${getContent.toString()},getLast: ${getLast.toString()},getNext: ${getNext.toString()},getArticleId: ${getArticleId.toString()},getTopicId: ${getTopicId.toString()}';
    return '{$string}';
  }
}
