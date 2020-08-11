import 'dart:io';

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
  File _localFile;
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
    print('loooooooooooooooooooooooooocal');
    print(v);
    setState(() {
      _done = true;
      _localpath = v;

      _localFile = new File(v);
    });
  }

  @override
  Widget build(BuildContext context) {
    final platform = Theme.of(context).platform;
    print(this._done);
    return Container(
      decoration: BoxDecoration(border: Border.all(color: myDarkBlue)),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          this._done
              ? Container(
                  child: ChewieListItem(
                    videoPlayerController: VideoPlayerController.file(
                     _localFile
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
                  : Container(
                      width: 150,
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
                          width: 200,
                          decoration: BoxDecoration(color: mylightBlue),
                          child: Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Text('شاهد الفيديو الآن...',
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          color: myDarkGrey,
                                          height: 1)))),
                        ),
                      ),
                    ),
          DownloaderSingle(
            callback: _donedown,
            platform: platform,
            link: {'name': this.widget.name, 'link': this.widget.url},
          ),
        ],
      ),
    );
  }
}
