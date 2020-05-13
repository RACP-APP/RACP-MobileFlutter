import 'package:flutter/material.dart';
import './video_handler.dart';
//import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_html/flutter_html.dart';
import '../utils/anlaytics.dart';

class Testing extends StatefulWidget {
  final int modelId;
  final int topicId;
  final int articleId;
  final List contentList;
  Testing(this.modelId, this.topicId, this.articleId, this.contentList);

  @override
  _Testing createState() => _Testing(modelId, topicId, articleId, contentList);
}

class _Testing extends State<Testing> {
  final int modelId;
  final int topicId;
  final int articleId;
  final List contentList;
  _Testing(this.modelId, this.topicId, this.articleId, this.contentList);
  final controller = ScrollController();
  DateTime begining;
  DateTime end;

  List listing() {
    List ordered = new List();

    if (contentList.length != 0) {
      List text = contentList[0]["text"];
      List media = contentList[0]["Media"];

      if (text != null) {
        for (var i = 0; i < text.length; i++) {
          ordered.add(text[i]);
        }
      }
      if (media != null) {
        for (var i = 0; i < media.length; i++) {
          ordered.add(media[i]);
        }
      }

      print(ordered);
    }
    return ordered;
  }

  Widget _contentItem(type, cont, txt, context) {
    if (type == "vedio") {
      return Container(
        padding: EdgeInsets.all(10.0),
        height: 265,
        child: Videohandler(name: "placeholder", url: cont),
      );
    } else if (type == "Text" && txt != null) {
      return Container(
        padding: EdgeInsets.only(bottom: 15),

        //height: MediaQuery.of(context).size.height / 1.1,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Html(
            defaultTextStyle: TextStyle(fontFamily: 'Free Serif'),
            data: txt,
            padding: EdgeInsets.all(12.0),
            customTextAlign: (node) {
              return TextAlign.justify;
            },
            customTextStyle: (node, TextStyle baseStyle) {
              return baseStyle.merge(TextStyle(height: 2, fontSize: 16));
            },
          ),
          /*
          Markdown(
            controller: controller,
            selectable: true,
            data: txt,
          ),
          */
        ),
      );
    } else if (type == "Image") {
      return Container(
        height: 265,
        width: double.maxFinite / 1.07,
        child: new Image.network(cont),
      );
    }
    return null;
  }

  setDuration(articleId) {
    begining = DateTime.now();
  }

  @override
  void didUpdateWidget(Testing oldWidget) {
    super.didUpdateWidget(oldWidget);
    end = DateTime.now();
    var duration = end.difference(begining).inMinutes;
    saveDuration(
        oldWidget.modelId, oldWidget.topicId, oldWidget.articleId, duration);
  }

  @override
  Widget build(BuildContext context) {
    setDuration(1);
    var gg = listing();
    return Container(
      color: Colors.white,
      width: double.maxFinite,
      height: double.maxFinite,
      child: ListView.builder(
          physics: const PageScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 1.0),
          scrollDirection: Axis.vertical,
          itemCount: gg.length,
          itemBuilder: (context, index) {
            var item = gg[index];
            return Container(
              padding: const EdgeInsets.only(
                  top: 0.0, bottom: 100.0, left: 0.0, right: 0.0),
              child: _contentItem(item['MediaType'], item['MediaLink'],
                  item["ContentText"], context),
            );
          }),
    );
  }
}
