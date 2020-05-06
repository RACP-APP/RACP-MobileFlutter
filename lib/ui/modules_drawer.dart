import 'package:flutter/material.dart';
import '../stores/drawer_store.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../stores/module_view_store.dart';
import '../stores/module_page_store.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/progress.dart';

class MyDrawer extends StatefulWidget {
  final List itemList;
  final String img;
  final int id;
  MyDrawer(this.itemList, this.img, this.id);

  @override
  _MyDrawer createState() => _MyDrawer(itemList, img, id);
}

class _MyDrawer extends State<MyDrawer> {
  _MyDrawer(this.itemList, this.img, this.id);
  final List itemList;
  final String img;
  final int id;
  final Map<int, dynamic> topics = new Map<int, dynamic>();
  final myDarkGrey = Color(0xff605E5E);
  final myDarkBlue = Color(0xff085576);
  final mylightBlue = Color(0xff8AD0EE);

  @override
  void initState() {
    super.initState();
    itemList.forEach((topic) {
      print(topic['Article'].length);
      if (topic['Article'].length != 0) {
        topics[topic['TopicID']] = new List<dynamic>();
        topic['Article'].forEach((article) {
          topics[topic['TopicID']].add({article['ArticleID']: false});
        });
      } else {
        topics[topic['TopicID']] = null;
      }
    });
  }

  setTopicAndArticleState(topicId, articleId) {
    setState(() {
      topics[topicId].forEach((article) {
        article.forEach((key, value) {
          if (key == articleId) {
            article[articleId] = true;
          }
        });
      });
    });
  }

  bool getTopicState(topicId) {
    bool topicState = true;

    if (topics[topicId] != null) {
      topics[topicId].forEach((article) {
        print(article);
        article.forEach((key, value) {
          topicState = topicState && value;
        });
      });
    } else {
      topicState = false;
    }
    return topicState;
  }

  bool getArticleState(topicId, articleId) {
    bool state = false;
    topics[topicId].forEach((article) {
      print(article);
      article.forEach((key, value) {
        if (key == articleId) {
          state = value;
        }
      });
    });
    return state;
  }

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
                }
                var state = getArticleState(topicId, item["ArticleID"]);

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
            //todoS
            itemStore.setCurrent(item["Title"]);
            _barStore.setCurrentName('hello');
            pageStore.setPage(content);

            // itemStore.setArticleState(topicId, item["ArticleID"], true);
            setTopicAndArticleState(topicId, item["ArticleID"]);

            setArticleCompleted(modelId, topicId, item["ArticleID"]).then((x) {
              getModelProgressPercent(modelId)
                  .then((value) {
                    print('heloo from thennnnnnnnnnnnnnnnnnnnnnnnnnn');
                    print(value);
                    pageStore.setProgress(value);});
            });
          },
          selected: itemStore.current == item["Title"] ? true : false,
        ),
      );
    }

    return Drawer(
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
                                    builder: (context,
                                        AsyncSnapshot<bool> snapshot) {
                                      if (snapshot.hasData) {
                                        allArticlesViewed = snapshot.data;
                                      }
                                      var topicState =
                                          getTopicState(item['TopicID']);

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
                                    decoration:
                                        BoxDecoration(color: myDarkBlue),
                                    child: Text(
                                      item["Title"],
                                      style: GoogleFonts.lateef(
                                          textStyle: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.white,
                                              height: 1.1)),
                                    )),
                                children: item["Article"].map<Widget>((item) {
                                  return articles(
                                      item,
                                      context,
                                      item["content"],
                                      this.id,
                                      item['TopicID']);
                                }).toList(),
                              ));
                        },
                      )),
            ),
          )
        ],
      ),
    );
  }
}
