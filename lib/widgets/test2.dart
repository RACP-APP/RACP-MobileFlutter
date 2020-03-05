import 'package:flutter/material.dart';
import './video_handler.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class Testing extends StatelessWidget {
  final List contentList;
  Testing({Key key, this.contentList}) : super(key: key);
  final controller = ScrollController();

  Widget _contentItem(type, cont, context) {
    if (type == "video") {
      return Container(
        height: 265,
        child: Videohandler(name: "placeholder", url: cont),
      );
    } else if (type == "text") {
      return Container(
        padding: EdgeInsets.only(bottom: 15),
        height: MediaQuery.of(context).size.height / 1.1,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child:
              /*Text(
          hmm,
          textDirection: TextDirection.rtl,
        ),*/

              Markdown(
            controller: controller,
            selectable: true,
            data: cont,
          ),
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
    return Container(
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
              child: _contentItem(item['type'], item['source'], context),
            );
          }),
    );
  }
}
