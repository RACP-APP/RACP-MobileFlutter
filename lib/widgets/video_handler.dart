import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../stores/video_handler_store.dart';
import 'package:provider/provider.dart';
import './file_downloader_single.dart';
import './video_p.dart';
import 'package:video_player/video_player.dart';

class Videohandler extends StatefulWidget {
  Videohandler({Key key, this.url, this.name}) : super(key: key);
  final String url;
  final String name;
  @override
  _VideohandlerState createState() => _VideohandlerState();
}

class _VideohandlerState extends State<Videohandler> {
  bool _done;
  bool _stream;
  String _localpath;

  @override
  void initState() {
    super.initState();
    _done = false;
    _stream = false;
    _localpath = null;
  }

  void _donedown(v) {
    setState(() {
      _done = true;
      _localpath = v;
    });
  }

  @override
  Widget build(BuildContext context) {
    var handlerStore = Provider.of<VideoStore>(context);
    final platform = Theme.of(context).platform;
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          this._done
              ? Container(
                  child: ChewieListItem(
                    videoPlayerController: VideoPlayerController.asset(
                      _localpath,
                    ),
                  ),
                )
              : this._stream
                  ? Container(
                      child: ChewieListItem(
                        videoPlayerController: VideoPlayerController.network(
                          this.widget.url,
                        ),
                      ),
                    )
                  : Expanded(
                      flex: 1,
                      child: RaisedButton(
                        onPressed: () {
                          setState(() {
                            _stream = true;
                          });
                        },
                        textColor: Colors.white,
                        padding: const EdgeInsets.all(0.0),
                        child: Container(
                          width: double.maxFinite,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: <Color>[
                                Color(0xFF0D47A1),
                                Color(0xFF1976D2),
                                Color(0xFF42A5F5),
                              ],
                            ),
                          ),
                          padding: const EdgeInsets.all(10.0),
                          child: const Text('watch online!',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20)),
                        ),
                      ),
                    ),
          Expanded(
            flex: 1,
            child: DownloaderSingle(
              callback: _donedown,
              platform: platform,
              link: {'name': this.widget.name, 'link': this.widget.url},
            ),
          )
        ],
      ),
    );
  }
}
