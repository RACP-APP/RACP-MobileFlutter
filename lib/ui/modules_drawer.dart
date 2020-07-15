import 'package:RACR/stores/progress_store.dart';
import 'package:flutter/material.dart';
import '../stores/drawer_store.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../stores/module_view_store.dart';
import '../stores/module_page_store.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../utils/progress.dart';

class MyDrawer extends StatefulWidget {
  final List itemList;
  final String img;
  final int id;
  final BuildContext original;
  MyDrawer(this.itemList, this.img, this.id, this.original);

  @override
  _MyDrawer createState() => _MyDrawer(itemList, img, id, original);
}

class _MyDrawer extends State<MyDrawer> {
  _MyDrawer(this.itemList, this.img, this.id, this.original);
  final List itemList;
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
    itemList.forEach((topic) {
      if (topic['Article'].length != 0) {
        topics[topic['TopicID']] = new List<dynamic>();
        topic['Article'].forEach((article) {
          topics[topic['TopicID']]
              .add({article['ArticleID']: false, "loading": false});
        });
        print('sttttttttttttttttttttttttttate');
        print(topics[topic['TopicID']]);
      } else {
        topics[topic['TopicID']] = null;
      }
    });
  }

  setTopicAndArticleState(topicId, articleId) {
    setState(() {
      if (topics[topicId] != null) {
        topics[topicId].forEach((article) {
          article.forEach((key, value) {
            if (key == articleId) {
              print(
                  'setting article icon state ssssssssssssssssssssssssssssssssss');
              print(article);
              article[articleId] = true;
              article["loading"] = false;
              print(article['loading']);
              print('try building sssssssssssssssssssssssssss');
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

  List getAudioFiles(article) {
    List audioFiles = new List();
    if (article['content'] != [] || article['content'] != null) {
      article['content'].forEach((content) {
        if (content['Media'] != null) {
          content['Media'].forEach((media) {
            if (media['MediaType'] == "audio") {
              audioFiles.add(media);
            }
          });
        }
      });
    }

    audioFiles.sort((a, b) => a["MediaOrder"].compareTo(b["MediaOrder"]));

    List audioFilesMediaLinks = new List();
    audioFiles.forEach((media) {
      audioFilesMediaLinks.add(media['MediaLink']);
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
    print('buildingggggggggggggggggggggggggggggggggggggg');
    var itemStore = Provider.of<DrawerStore>(context);
    var _barStore = Provider.of<ViewStore>(context);
    var pageStore = Provider.of<PageStore>(context);
    var progressStore = Provider.of<ProgressStore>(context);
    bool viewed = false;
    bool allArticlesViewed = false;
    var drawerContext = context;

    List listing(contentList) {
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
      }
      // order the ordered content according to the mediaOrder attribute
      ordered.sort((a, b) => a['MediaOrder'].compareTo(b['MediaOrder']));
      return ordered;
    }

    Widget articles(item, context, content, modelId, topicId) {
      var originalCxt = context;
      return Observer(
        builder: (_) => ListTile(
          contentPadding: EdgeInsets.fromLTRB(30.0, 5.0, 5.0, 10.0),
          leading: FutureBuilder<bool>(
              future: getIfArticleViewed(modelId, topicId, item["ArticleID"]),
              builder: (context, AsyncSnapshot<bool> snapshot) {
                if (snapshot.hasData) {
                  viewed = snapshot.data;
                }
                int state = getArticleState(topicId, item["ArticleID"]);
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
            int state = getArticleState(topicId, item["ArticleID"]);

            itemStore.setCurrent(item["Title"]);
            _barStore.setCurrentName('hello');
            var orderedContent = listing(content);
            pageStore.setContent(orderedContent);
            pageStore.setTopicId(topicId);
            pageStore.setArticleId(item["ArticleID"]);
            pageStore.setAudioFiles(getAudioFiles(item));
           

            // itemStore.setArticleState(topicId, item["ArticleID"], true);
            if (state == 0) {
              setTopicAndArticleStateLoading(topicId, item["ArticleID"]);
              setArticleCompleted(modelId, topicId, item["ArticleID"])
                  .then((x) {
                getModelProgressPercent(modelId).then((value) {
                  if (value == 1) {
                    showCompletedAlert(context);
                  }
                  return value;
                }).then((value) {
                  print('progress of the model *************************');
                  print(value);
                  progressStore.setModuleProgress(modelId, value);
                  // TODO CALCULATE THE OVERALL PROGRESS
                  progressStore.setOverAllProgress(100);
                   print('***************orignal****************');
                  print(originalCxt);
                  print(context);
                  Navigator.pop(context);
                });
              }).then((value) =>
                      setTopicAndArticleState(topicId, item["ArticleID"]));
            }
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
                            future: getIfAllArticlesViewed(
                                this.id, item['TopicID']),
                            builder: (context, AsyncSnapshot<bool> snapshot) {
                              if (snapshot.hasData) {
                                allArticlesViewed = snapshot.data;
                              }
                              var topicState = getTopicState(item['TopicID']);

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
                          return articles(item, drawerContext, item["content"],
                              this.id, item['TopicID']);
                        }).toList(),
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
