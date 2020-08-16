import 'package:RACR/stores/progress_store.dart';
import 'package:RACR/utils/db.dart';
import 'package:flutter/material.dart';
import '../stores/drawer_store.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../stores/module_view_store.dart';
import '../stores/module_page_store.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../utils/progress_db.dart';

class MyDrawer extends StatefulWidget {
  final List itemList;
  final Map<int, dynamic> topicsArticles;
  final String img;
  final int id;
  final BuildContext original;
  MyDrawer(
      this.itemList, this.topicsArticles, this.img, this.id, this.original);

  @override
  _MyDrawer createState() =>
      _MyDrawer(itemList, topicsArticles, img, id, original);
}

class _MyDrawer extends State<MyDrawer> {
  _MyDrawer(
      this.itemList, this.topicsArticles, this.img, this.id, this.original);
  final List itemList;
  final Map<int, dynamic> topicsArticles;
  final String img;
  final int id;
  final BuildContext original;
  final Map<int, dynamic> topics = new Map<int, dynamic>();
  final myDarkGrey = Color(0xff605E5E);
  final myDarkBlue = Color(0xff085576);
  final mylightBlue = Color(0xff8AD0EE);

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies(){
    setTopicsAndArticles();
  }

  setTopicsAndArticles() {
    var storeP = Provider.of<PageStore>(context);
    for (var topic in itemList) {
      List articles = topicsArticles[topic['TOPIC_ID']];

      if (articles.length != 0) {
        topics[topic['TOPIC_ID']] = new List<dynamic>();

        articles.forEach((article) {
          bool selected = false;
          if (storeP.getTopicId == topic['TOPIC_ID'] &&
              storeP.getArticleId == article['ARTICLE_ID']) {
            selected = true;
          }

          topics[topic['TOPIC_ID']].add({
            article['ARTICLE_ID']: false,
            "loading": false,
            "selected": selected
          });
        });
      } else {
        topics[topic['TOPIC_ID']] = null;
      }
    }
  }

  setTopicAndArticleState(topicId, articleId) {
    setState(() {
      if (topics[topicId] != null) {
        topics[topicId].forEach((article) {
          article.forEach((key, value) {
            if (key == articleId) {
              article[articleId] = true;
              article["loading"] = false;
            }
          });
        });
      }
    });
  }

  setTopicAndArticleStateLoading(topicId, articleId) {
    setState(() {
      topics[topicId].forEach((article) {
        article.forEach((key, value) {
          if (key == articleId) {
            if (!value) {
              article["loading"] = true;
              article["selected"] = true;
            } else {
              article["loading"] = false;
              article["selected"] = false;
            }
          }
        });
      });
    });
  }

  bool getTopicState(topicId) {
    bool topicState = true;

    if (topics[topicId] != null) {
      topics[topicId].forEach((article) {
        article.forEach((key, value) {
          topicState = topicState && value;
        });
      });
    } else {
      topicState = false;
    }
    return topicState;
  }

  int getArticleState(topicId, articleId) {
    int state = 0;
    topics[topicId].forEach((article) {
      article.forEach((key, value) {
        if (key == articleId) {
          if (article['loading']) {
            state = 1; // show loading indicator
          } else {
            if (value) {
              state = 2; // show the check mark;
            } else {
              state = 0; // leave it as it is
            }
          }
        }
      });
    });
    return state;
  }

bool getArticleSelected(topicId, articleId) {
    bool selected = false;
    topics[topicId].forEach((article) {
      article.forEach((key, value) {
        if (key == articleId) {
          selected = article['selected'];
        }
      });
    });
    return selected;
  }
  List getAudioFiles(articleContent) {
    List audioFiles = new List();
    if (articleContent != [] || articleContent != null) {
      articleContent.forEach((content) {
        if (content['CONTENT_TYPE'] == 'audio') {
          audioFiles.add(content);
        }
      });
    }
    audioFiles.sort((a, b) => a["CONTENT_ORDER"].compareTo(b["CONTENT_ORDER"]));

    List audioFilesMediaLinks = new List();
    audioFiles.forEach((media) {
      audioFilesMediaLinks.add(media['CONTENT_DETIALS']);
    });
    return audioFilesMediaLinks;
  }

  void showCompletedAlert(context) {
    final myDarkBlueOverlay = Color(0x55085576);

    Alert(
        context: context,
        title:
            "تهانينا! باكمالك قراءة هذه المقالة تكون قد أكملت قراءة الموضوع كاملاً",
        buttons: [],
        style: AlertStyle(
          animationType: AnimationType.grow,
          descStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          animationDuration: Duration(milliseconds: 400),
          backgroundColor: myDarkBlue,
          alertBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: myDarkBlue,
            ),
          ),
          titleStyle: TextStyle(
            color: Colors.white,
          ),
          overlayColor: myDarkBlueOverlay,
        )).show();
  }

  @override
  Widget build(BuildContext context) {
    var itemStore = Provider.of<DrawerStore>(context);
    var pageStore = Provider.of<PageStore>(context);
    var progressStore = Provider.of<ProgressStore>(context);
    bool viewed = false;
    bool allArticlesViewed = false;
    var drawerContext = context;

    Widget articles(item, context, modelId, topicId)  {
      return 
        Container(
                  color:getArticleSelected(topicId, item["ARTICLE_ID"]) ? mylightBlue : myDarkBlue,
                  child:ListTile(
          contentPadding: EdgeInsets.fromLTRB(30.0, 5.0, 5.0, 10.0),
          leading: FutureBuilder<bool>(
              future: getIfArticleViewed(modelId, topicId, item["ARTICLE_ID"]),
              builder: (context, AsyncSnapshot<bool> snapshot) {
                if (snapshot.hasData) {
                  viewed = snapshot.data;
                }
                int state = getArticleState(topicId, item["ARTICLE_ID"]);
                bool iconState = false;
                bool loading = false;
                switch (state) {
                  case 0:
                    iconState = false;
                    break;
                  case 1:
                    loading = true;
                    break;
                  case 2:
                    iconState = true;
                    break;
                }

                return loading
                    ? CircularProgressIndicator()
                    : Icon(
                        viewed || iconState ? Icons.done : Icons.remove,
                        color: getArticleSelected(topicId, item["ARTICLE_ID"]) ? myDarkBlue: mylightBlue,
                        size: 20,
                      );
              }),
          title: Text("${item["TITLE"]}",
              style: GoogleFonts.lateef(
                  textStyle: TextStyle(
                      fontSize: 18.0, color: Colors.white, height: 1.1))),
          trailing: Icon(Icons.keyboard_arrow_right, color: mylightBlue),
          onTap: () async {
            //todoS
            bool state =
                await getIfArticleViewed(modelId, topicId, item["ARTICLE_ID"]);

            itemStore.setCurrent(item["TITLE"]);
            var orderedContent = await getContentByArticleId(
                modelId, topicId, item["ARTICLE_ID"]);

            pageStore.setContent(orderedContent);
            pageStore.setTopicId(topicId);

            pageStore.setArticleId(item["ARTICLE_ID"]);

            pageStore.setAudioFiles(getAudioFiles(orderedContent));
            if (!state) {
              setTopicAndArticleStateLoading(topicId, item["ARTICLE_ID"]);
              await setArticleCompleted(modelId, topicId, item["ARTICLE_ID"]);
              var value = await getModelProgressPercent(modelId);

              progressStore.setModuleProgress(modelId, value);
              var newOverAllProgress = await getOverallProgressPercent();

              progressStore.setOverAllProgress(newOverAllProgress);
              setTopicAndArticleState(topicId, item["ARTICLE_ID"]);
              if (value == 1) {
                showCompletedAlert(drawerContext);

                // showCompletedAlert(drawerContext);
              } else {
                Navigator.pop(context);
              }
            } else {
              Navigator.pop(context);
            }
          },
          selected: getArticleSelected(topicId, item["ARTICLE_ID"]),
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
              child: ListView.builder(
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
                            future: getIfAllArticlesViewedOfAtopic(
                                this.id, item['TOPIC_ID']),
                            builder: (context, AsyncSnapshot<bool> snapshot) {
                              if (snapshot.hasData) {
                                allArticlesViewed = snapshot.data;
                              }
                              var topicState = getTopicState(item['TOPIC_ID']);
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
                              item["TITLE"],
                              style: GoogleFonts.lateef(
                                  textStyle: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.white,
                                      height: 1.1)),
                            )),
                        children: topicsArticles[item['TOPIC_ID']] != null
                            ? topicsArticles[item['TOPIC_ID']]
                                .map<Widget>((article) {
                                return articles(article, drawerContext, this.id,
                                    article['TOPIC_ID']);
                              }).toList()
                            : [],
                      ));
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
