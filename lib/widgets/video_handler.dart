import 'package:flutter/material.dart';

import './file_downloader_single.dart';
import './video_p.dart';
import 'package:video_player/video_player.dart';
import 'package:google_fonts/google_fonts.dart';

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
  final myDarkGrey = Color(0xff605E5E);
  final myDarkBlue = Color(0xff085576);
  final mylightBlue = Color(0xff8AD0EE);

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
    final platform = Theme.of(context).platform;
    return Container(
      decoration: BoxDecoration(border: Border.all(color: myDarkBlue)),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
              child: this._done
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
                            videoPlayerController:
                                VideoPlayerController.network(
                              this.widget.url,
                            ),
                          ),
                        )
                      : Container(
                          width: 230,
                          margin: EdgeInsets.only(top: 20),
                          child: RaisedButton(
                            onPressed: () {
                              setState(() {
                                _stream = true;
                              });
                            },
                            textColor: myDarkGrey,
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20.0),
                            ),
                            color: mylightBlue,
                            child: Container(
                              width: double.maxFinite,
                              decoration: BoxDecoration(color: mylightBlue),
                              padding:
                                  const EdgeInsets.fromLTRB(10.0, 10.0, 10, 10),
                              child: Padding(
                                  padding: EdgeInsets.only(right: 8.0),
                                  child: Text('شاهد الفيديو الآن...',
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          color: myDarkGrey,
                                          height: 1))),
                            ),
                          ),
                        ),
              flex: 4),
          Expanded(
            //nu
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
