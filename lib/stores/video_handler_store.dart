import 'package:mobx/mobx.dart';

part 'video_handler_store.g.dart';

class VideoStore = _VideoStore with Store;

abstract class _VideoStore with Store {
  @observable
  bool done = false;
  @observable
  bool stream = false;

  @computed
  bool get getDone => done;
  @computed
  bool get getStream => stream;

  @action
  void setDone() {
    done = true;
  }

  @action
  void setStream(v) {
    print(stream);
    stream = v;
  }
}
