import 'package:RACR/stores/module_page_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import './video_handler.dart';
import '../utils/anlaytics.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class MContent extends StatefulWidget {
  final int modelId;
  final int topicId;
  final int articleId;
  final List contentList;
  MContent(this.modelId, this.topicId, this.articleId, this.contentList);

  @override
  _MContent createState() =>
      _MContent(modelId, topicId, articleId, contentList);
}

class _MContent extends State<MContent> {
  final int modelId;
  final int topicId;
  final int articleId;
  final List contentList;
  _MContent(this.modelId, this.topicId, this.articleId, this.contentList);
  final controller = ScrollController();
  DateTime begining;
  DateTime end;

  Widget _contentItem(type, cont, txt, context) {
    if (type == "vedio") {
      return Container(
        padding: EdgeInsets.all(0),
        child: Videohandler(name: "placeholder", url: cont),
      );
    } else if (type == "Text" && txt != null) {
      return Container(
        padding: EdgeInsets.all(0),
        //height: MediaQuery.of(context).size.height / 1.1,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: HtmlWidget(txt,webView:true),
        ),
      );
    } else if (type == "Image") {
      return Container(
        padding: EdgeInsets.all(0),
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
  void didUpdateWidget(MContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    end = DateTime.now();
    var duration = end.difference(begining).inMinutes;
    saveDuration(
        oldWidget.modelId, oldWidget.topicId, oldWidget.articleId, duration);
  }

  @override
  Widget build(BuildContext context) {
    setDuration(articleId);
    var storeP = Provider.of<PageStore>(context);

    return Container(
      color: Colors.white,
      width: double.maxFinite,
      height: double.maxFinite,
      child: Observer(
          builder: (_) => ListView.builder(
              physics: const PageScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 1.0),
              scrollDirection: Axis.vertical,
              itemCount: storeP.getContent.length,
              itemBuilder: (context, index) {
                var item = storeP.getContent[index];
                return Container(
                  padding: const EdgeInsets.only(
                      top: 0.0, bottom: 0.0, left: 0.0, right: 0.0),
                  child: _contentItem(item['MediaType'], item['MediaLink'],
                      item["ContentText"], context),
                );
              })),
    );
  }
}
