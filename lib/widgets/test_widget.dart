import 'package:flutter/material.dart';
import './file_downloader_single.dart';

class Yes extends StatelessWidget {
  const Yes({Key key}) : super(key: key);

  Widget build(BuildContext context) {
    final platform = Theme.of(context).platform;
    return Scaffold(
      appBar: AppBar(title: Text('Container as a layout')),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.yellowAccent,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: DownloaderSingle(
                link: {
                  'name': 'Big Buck Bunny',
                  'link':
                      'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4'
                },
                platform: platform,
              ),
            ),
            Expanded(flex: 8, child: Text("loool"))
          ],
        ),
      ),
    );
  }
}
