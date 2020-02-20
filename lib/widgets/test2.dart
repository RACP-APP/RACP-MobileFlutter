import 'package:flutter/material.dart';
import './file_downloader_single.dart';
import './video_handler.dart';
import 'package:provider/provider.dart';
import '../stores/video_handler_store.dart';

class Testing extends StatelessWidget {
  final List contentList;
  const Testing({Key key, this.contentList}) : super(key: key);

  Widget _contentItem(type, cont) {
    if (type == "video") {
      return Container(
        height: 265,
        child: Videohandler(name: "placeholder", url: cont),
      );
    } else if (type == "text") {
      return Container(
        height: double.maxFinite,
        child: Text(
          cont,
          textAlign: TextAlign.justify,
          textDirection: TextDirection.rtl,
        ),
      );
    } else if (type == "image") {
      return Container(
        height: 265,
        width: double.maxFinite / 1.07,
        child: new Image.network(cont),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<VideoStore>(create: (_) => VideoStore()),
      ],
      child: Container(
        color: Colors.white,
        width: double.maxFinite,
        height: double.maxFinite,
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: contentList.length,
            itemBuilder: (context, index) {
              var item = contentList[index];
              return Container(
                padding: const EdgeInsets.only(
                    top: 0.0, bottom: 100.0, left: 0.0, right: 0.0),
                child: _contentItem(item['type'], item['content']),
              );
            }),
      ),
    );
  }
}
