import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

import 'package:path/path.dart';

class DownloaderSingle extends StatefulWidget with WidgetsBindingObserver {
  final TargetPlatform platform;
  final callback;

  DownloaderSingle({Key key, this.platform, this.link, this.callback})
      : super(key: key);

  final Map link;

  @override
  _DownloaderSingleState createState() => new _DownloaderSingleState();
}

class _DownloaderSingleState extends State<DownloaderSingle> {
  _TaskInfo _task;
  _ItemHolder _item;
  bool _isLoading;
  bool _permissionReady;
  String _localPath;
  ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();

    _bindBackgroundIsolate();

    FlutterDownloader.registerCallback(downloadCallback);

    _isLoading = true;
    _permissionReady = false;

    _prepare();
  }

  @override
  void dispose() {
    _unbindBackgroundIsolate();
    super.dispose();
  }

  void _bindBackgroundIsolate() {
    bool isSuccess = IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    if (!isSuccess) {
      _unbindBackgroundIsolate();
      _bindBackgroundIsolate();
      return;
    }
    _port.listen((dynamic data) {
      print('UI Isolate Callback: $data');
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];

      final task = _task.taskId == id;
      if (task != null) {
        setState(() {
          _task.status = status;
          _task.progress = progress;
        });
      }
    });
  }

  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    print(
        'Background Isolate Callback: task ($id) is in status ($status) and process ($progress)');
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send.send([id, status, progress]);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Builder(
        builder: (context) => _isLoading
            ? new Center(
                child: new CircularProgressIndicator(),
              )
            : _permissionReady
                ? new Container(
                    // height: MediaQuery.of(context).size.height,
                    // width: MediaQuery.of(context).size.width,
                    child: new Row(
                      children: <Widget>[
                        new Container(
                          padding:
                              const EdgeInsets.only(left: 16.0, right: 8.0),
                          child: InkWell(
                            onTap: _item.task.status ==
                                    DownloadTaskStatus.complete
                                ? () {
                                    _openDownloadedFile(_item.task)
                                        .then((success) {
                                      if (!success) {
                                        Scaffold.of(context).showSnackBar(
                                            SnackBar(
                                                duration: Duration(seconds: 1),
                                                content: Text(
                                                    'Cannot open this file')));
                                      }
                                    });
                                  }
                                : null,
                            child: new Stack(
                              children: <Widget>[
                                new Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.18,
                                  height: 50,
                                  child: new Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      new Expanded(
                                        child: new Text(
                                          _item.name,
                                          maxLines: 1,
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      new Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: _buildActionForTask(_item.task),
                                      ),
                                    ],
                                  ),
                                ),
                                _item.task.status ==
                                            DownloadTaskStatus.running ||
                                        _item.task.status ==
                                            DownloadTaskStatus.paused
                                    ? new Container(
                                        child: Positioned(
                                          left: 0.0,
                                          right: 0.0,
                                          bottom: 0.0,
                                          child: new LinearProgressIndicator(
                                            value: _item.task.progress / 100,
                                          ),
                                        ),
                                      )
                                    : new Container()
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : new Container(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Text(
                              'Please grant accessing storage permission to continue ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.blueGrey, fontSize: 18.0),
                            ),
                          ),
                          SizedBox(
                            height: 32.0,
                          ),
                          FlatButton(
                              onPressed: () {
                                _checkPermission().then((hasGranted) {
                                  setState(() {
                                    _permissionReady = hasGranted;
                                  });
                                });
                              },
                              child: Text(
                                'Retry',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ))
                        ],
                      ),
                    ),
                  ),
      ),
    );
  }

  Widget _buildActionForTask(_TaskInfo task) {
    if (task.status == DownloadTaskStatus.undefined) {
      return new RawMaterialButton(
        onPressed: () {
          _requestDownload(task);
        },
        child: new Icon(Icons.file_download),
        shape: new CircleBorder(),
        constraints: new BoxConstraints(minHeight: 32.0, minWidth: 32.0),
      );
    } else if (task.status == DownloadTaskStatus.running) {
      // add cancel

      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          new RawMaterialButton(
            onPressed: () {
              _pauseDownload(task);
            },
            child: new Icon(
              Icons.pause,
              color: Colors.red,
            ),
            shape: new CircleBorder(),
            constraints: new BoxConstraints(minHeight: 32.0, minWidth: 32.0),
          ),
          RawMaterialButton(
            onPressed: () {
              _cancelDownload(task);
            },
            child: Icon(
              Icons.cancel,
              color: Colors.red,
            ),
            shape: new CircleBorder(),
            constraints: new BoxConstraints(minHeight: 32.0, minWidth: 32.0),
          )
        ],
      );
    } else if (task.status == DownloadTaskStatus.paused) {
      return new RawMaterialButton(
        onPressed: () {
          _resumeDownload(task);
        },
        child: new Icon(
          Icons.play_arrow,
          color: Colors.green,
        ),
        shape: new CircleBorder(),
        constraints: new BoxConstraints(minHeight: 32.0, minWidth: 32.0),
      );
    } else if (task.status == DownloadTaskStatus.complete &&
        _exists(task.link) == false) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          new Text(
            'have you deleted it ?',
            style: new TextStyle(color: Colors.red),
          ),
          RawMaterialButton(
            onPressed: () {
              _requestDownload(task);
            },
            child: Icon(
              Icons.refresh,
              color: Colors.red,
            ),
            shape: new CircleBorder(),
            constraints: new BoxConstraints(minHeight: 32.0, minWidth: 32.0),
          )
        ],
      );
    } else if (task.status == DownloadTaskStatus.complete) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          RawMaterialButton(
            onPressed: () {
              this.widget.callback(_doneexists(task.link));
            },
            child: Icon(
              Icons.play_arrow,
              color: Colors.red,
            ),
            shape: new CircleBorder(),
            constraints: new BoxConstraints(minHeight: 32.0, minWidth: 32.0),
          ),
          new Text(
            'Ready',
            style: new TextStyle(color: Colors.green),
          ),
          RawMaterialButton(
            onPressed: () {
              _delete(task);
            },
            child: Icon(
              Icons.delete_forever,
              color: Colors.red,
            ),
            shape: new CircleBorder(),
            constraints: new BoxConstraints(minHeight: 32.0, minWidth: 32.0),
          )
        ],
      );
    } else if (task.status == DownloadTaskStatus.canceled) {
      return new Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          new Text('Cancled', style: new TextStyle(color: Colors.red)),
          RawMaterialButton(
            onPressed: () {
              _retryDownload(task);
            },
            child: Icon(
              Icons.refresh,
              color: Colors.green,
            ),
            shape: new CircleBorder(),
            constraints: new BoxConstraints(minHeight: 32.0, minWidth: 32.0),
          )
        ],
      );
    } else if (task.status == DownloadTaskStatus.failed) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          new Text('Failed', style: new TextStyle(color: Colors.red)),
          RawMaterialButton(
            onPressed: () {
              _retryDownload(task);
            },
            child: Icon(
              Icons.refresh,
              color: Colors.green,
            ),
            shape: new CircleBorder(),
            constraints: new BoxConstraints(minHeight: 32.0, minWidth: 32.0),
          )
        ],
      );
    } else {
      return null;
    }
  }

  void _requestDownload(_TaskInfo task) async {
    task.taskId = await FlutterDownloader.enqueue(
        url: task.link,
        headers: {"auth": "test_for_sql_encoding"},
        savedDir: _localPath,
        showNotification: true,
        openFileFromNotification: true);
  }

  void _cancelDownload(_TaskInfo task) async {
    await FlutterDownloader.cancel(taskId: task.taskId);
  }

  void _pauseDownload(_TaskInfo task) async {
    await FlutterDownloader.pause(taskId: task.taskId);
  }

  void _resumeDownload(_TaskInfo task) async {
    String newTaskId = await FlutterDownloader.resume(taskId: task.taskId);
    task.taskId = newTaskId;
  }

  void _retryDownload(_TaskInfo task) async {
    String newTaskId = await FlutterDownloader.retry(taskId: task.taskId);
    task.taskId = newTaskId;
  }

  Future<bool> _openDownloadedFile(_TaskInfo task) async {
    if (_exists(task.link) == true) {
      setState(() {});
      return FlutterDownloader.open(taskId: task.taskId);
    } else {
      setState(() {});
      return false;
    }
  }

  void _delete(_TaskInfo task) async {
    await FlutterDownloader.remove(
        taskId: task.taskId, shouldDeleteContent: true);
    await _prepare();
    setState(() {});
  }

  Future<bool> _checkPermission() async {
    if (widget.platform == TargetPlatform.android) {
      PermissionStatus permission = await PermissionHandler()
          .checkPermissionStatus(PermissionGroup.storage);
      if (permission != PermissionStatus.granted) {
        Map<PermissionGroup, PermissionStatus> permissions =
            await PermissionHandler()
                .requestPermissions([PermissionGroup.storage]);
        if (permissions[PermissionGroup.storage] == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  Future<Null> _prepare() async {
    final tasks = await FlutterDownloader.loadTasks();

    _task = (_TaskInfo(
        name: this.widget.link['name'], link: this.widget.link['link']));

    _item = (_ItemHolder(name: _task.name, task: _task));

    tasks?.forEach((task) {
      if (_task.link == task.url) {
        _task.taskId = task.taskId;
        _task.status = task.status;
        _task.progress = task.progress;
      }
    });

    _permissionReady = await _checkPermission();

    _localPath = (await _findLocalPath()) + Platform.pathSeparator + 'Download';

    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }

    setState(() {
      _isLoading = false;
    });
  }

  bool _exists(String path) {
    File file = new File(path);
    String filename = basename(file.path);
    final savePath = _localPath + "/" + filename;
    bool lol = File(savePath).existsSync();
    print(savePath);
    if (lol) {
      print("exists??");
      return true;
    } else {
      print("no");
      return false;
    }
  }

  String _doneexists(String path) {
    File file = new File(path);
    String filename = basename(file.path);
    final savePath = _localPath + "/" + filename;

    print(savePath);
    return savePath;
  }

  Future<String> _findLocalPath() async {
    final directory = widget.platform == TargetPlatform.android
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    return directory.path;
  }
}

class _TaskInfo {
  final String name;
  final String link;

  String taskId;
  int progress = 0;
  DownloadTaskStatus status = DownloadTaskStatus.undefined;

  _TaskInfo({this.name, this.link});
}

class _ItemHolder {
  final String name;
  final _TaskInfo task;

  _ItemHolder({this.name, this.task});
}
