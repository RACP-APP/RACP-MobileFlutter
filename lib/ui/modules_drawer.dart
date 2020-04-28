import 'package:flutter/material.dart';
import '../stores/drawer_store.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../stores/module_view_store.dart';
import '../stores/module_page_store.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/progress.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer(this.itemList, this.img, this.id);
  final List itemList;
  final String img;
  final int id;
  final myDarkGrey = Color(0xff605E5E);
  final myDarkBlue = Color(0xff085576);
  final mylightBlue = Color(0xff8AD0EE);
  @override
  Widget build(BuildContext context) {
    var itemStore = Provider.of<DrawerStore>(context);
    var _barStore = Provider.of<ViewStore>(context);
    var pageStore = Provider.of<PageStore>(context);
    bool viewed = false;
    bool allArticlesViewed = false;
    Widget articles(item, context, content, modelId, topicId) {
      return Observer(
        builder: (_) => ListTile(
          contentPadding: EdgeInsets.fromLTRB(30.0, 5.0, 5.0, 10.0),
          leading: FutureBuilder<bool>(
              future: getIfArticleViewed(modelId, topicId, item["ArticleID"]),
              builder: (context, AsyncSnapshot<bool> snapshot) {
                if (snapshot.hasData) {
                  viewed = snapshot.data;
                  print(
                      '***************************article viewed***************************');
                  print(item["ArticleID"]);
                  print(viewed);
                }
                var state =
                    itemStore.getArticleState(topicId, item["ArticleID"]) ==
                            null
                        ? false
                        : itemStore.getArticleState(topicId, item["ArticleID"]);
                return Icon(
                  viewed || state ? Icons.done : Icons.remove,
                  color: mylightBlue,
                  size: 20,
                );
              }),
          title: Text("${item["Title"]}",
              style: GoogleFonts.lateef(
                  textStyle: TextStyle(
                      fontSize: 18.0, color: Colors.white, height: 1.1))),
          trailing: Icon(Icons.keyboard_arrow_right, color: mylightBlue),
          onTap: () async {
            //todo
            itemStore.setCurrent(item["Title"]);
            _barStore.setCurrentName(itemStore.getCurrent);
            pageStore.setPage(content);
            itemStore.setArticleState(topicId, item["ArticleID"], true);
            itemStore.setTopicState(topicId);
print('44444444444444444 topic State set 44444444444444444444 ');
            await setArticleCompleted(modelId, topicId, item["ArticleID"]);
          },
          selected: itemStore.current == item["Title"] ? true : false,
        ),
      );
    }
print('rebuilddddddddddddddddddddddddddddddddddddddd');
    return  Observer(
        builder: (_) => Drawer(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 20,
            child: DrawerHeader(
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.all(0),
              child: Container(
                height: 100,
                margin: EdgeInsets.all(0),
                padding: EdgeInsets.all(0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: new NetworkImage(this.img),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 85,
            child: Container(
                color: myDarkBlue,
                child: Observer(
                  builder: (_) => ListView.builder(
                    padding: EdgeInsets.all(0),
                    scrollDirection: Axis.vertical,
                    itemCount: itemList.length,
                    //itemExtent: 100.0,
                    itemBuilder: (context, index) {
                      var item = itemList[index];
                      return Container(
                          margin: EdgeInsets.all(0),
                          decoration: BoxDecoration(color: myDarkBlue),
                          child: ExpansionTile(
                            leading: FutureBuilder<bool>(
                                future: getIfAllArticlesViewed(
                                    this.id, item['TopicID']),
                                builder:
                                    (context, AsyncSnapshot<bool> snapshot) {
                                  if (snapshot.hasData) {
                                    allArticlesViewed = snapshot.data;
                                    print(
                                        '***************************all article viewed***************************');
                                    print(allArticlesViewed);
                                  }
                                  var topicState =
                                      itemStore.topics[item['TopicID']] == null ?false:itemStore.topics[item['TopicID']];
                                  print(
                                      '***************************all article viewed state***************************');
                                  print(topicState);
                                  return Icon(
                                    allArticlesViewed || topicState
                                        ? Icons.done_all
                                        : Icons.remove,
                                    color: mylightBlue,
                                    size: 20,
                                  );
                                }),
                            title: Container(
                                padding: EdgeInsets.only(left: 0),
                                decoration: BoxDecoration(color: myDarkBlue),
                                child: Text(
                                  item["Title"],
                                  style: GoogleFonts.lateef(
                                      textStyle: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.white,
                                          height: 1.1)),
                                )),
                            children: item["Article"].map<Widget>((item) {
                              var articlesExist= itemStore.getIfArticlesExist(item['TopicID']);
                              print('---------article if exists----------------');
                              print(articlesExist);
                              if(!articlesExist){
                                print('---------article set exists----------------');
                              itemStore.setArticleState(
                                  item['TopicID'], item['ArticleID'], false);
                              };
                              return articles(item, context, item["content"],
                                  this.id, item['TopicID']);
                            }).toList(),
                          )
                          );
                    },
                  ),
                )
                ),
          )
        ],
      ),
    ));
  }
}
