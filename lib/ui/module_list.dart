import 'package:flutter/material.dart';

import 'package:expandable/expandable.dart';
import "package:percent_indicator/circular_percent_indicator.dart";

class ModulesList extends StatelessWidget {
  ModulesList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyCustomAppBar(height: 58),
      body: ExpandableTheme(
        data:
            const ExpandableThemeData(iconColor: Colors.blue, useInkWell: true),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: <Widget>[Card1(), Card2()],
        ),
      ),
    );
  }
}

class Card1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    buildCollapsed1() {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "My Classes",
                    style: Theme.of(context).textTheme.body1,
                  ),
                ],
              ),
            ),
          ]);
    }

    buildCollapsed2() {
      return HoriView();
      //buildImg(Colors.lightGreenAccent, 150);
    }

    buildCollapsed3() {
      return Container();
    }

    buildExpanded1() {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "My Classes",
                    style: Theme.of(context).textTheme.body1,
                  ),
                  Text(
                    "Get back straight to where you left!",
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ),
          ]);
    }

    buildExpanded2() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new CircularPercentIndicator(
                radius: 120.0,
                lineWidth: 13.0,
                animation: true,
                animationDuration: 1200,
                percent: 0.3,
                center: new Text(
                  "30.0%",
                  style: new TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                footer: new Text(
                  "Over All Prpgress",
                  style: new TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 17.0),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Colors.lightBlue,
              ),
            ],
          ),
        ],
      );
    }

    buildExpanded3() {
      return Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            VerticalView(true),
            //VeView(),
          ],
        ),
      );
    }

    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: ScrollOnExpand(
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expandable(
                  collapsed: buildCollapsed1(),
                  expanded: buildExpanded1(),
                ),
                Expandable(
                  collapsed: buildCollapsed2(),
                  expanded: buildExpanded2(),
                ),
                Expandable(
                  collapsed: buildCollapsed3(),
                  expanded: buildExpanded3(),
                ),
                Divider(
                  height: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Builder(
                      builder: (context) {
                        var controller = ExpandableController.of(context);
                        return FlatButton(
                          child: Text(
                            controller.expanded ? "COLLAPSE" : "EXPAND",
                            style: Theme.of(context)
                                .textTheme
                                .button
                                .copyWith(color: Colors.deepPurple),
                          ),
                          onPressed: () {
                            controller.toggle();
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Card2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    buildCollapsed1() {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "All available Classes",
                    style: Theme.of(context).textTheme.body1,
                  ),
                ],
              ),
            ),
          ]);
    }

    buildCollapsed2() {
      return HoriView();
      //buildImg(Colors.lightGreenAccent, 150);
    }

    buildCollapsed3() {
      return Container();
    }

    buildExpanded1() {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "All available Classes",
                    style: Theme.of(context).textTheme.body1,
                  ),
                  Text(
                    "Pick one!",
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ),
          ]);
    }

    buildExpanded3() {
      return Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            VerticalView(false),
          ],
        ),
      );
    }

    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: ScrollOnExpand(
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expandable(
                  collapsed: buildCollapsed1(),
                  expanded: buildExpanded1(),
                ),
                Expandable(
                  collapsed: buildCollapsed2(),
                  expanded: null,
                ),
                Expandable(
                  collapsed: buildCollapsed3(),
                  expanded: buildExpanded3(),
                ),
                Divider(
                  height: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Builder(
                      builder: (context) {
                        var controller = ExpandableController.of(context);
                        return FlatButton(
                          child: Text(
                            controller.expanded ? "COLLAPSE" : "EXPAND",
                            style: Theme.of(context)
                                .textTheme
                                .button
                                .copyWith(color: Colors.deepPurple),
                          ),
                          onPressed: () {
                            controller.toggle();
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String sss = "إليك بعض الأمور الواجب وضعها بعين الإعتبار:";

List foo() {
  List<Map> data = List();
  data.add({
    "name": "me",
    "icon":
        "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRsL5VdbK7PeZ-buGy6QcdYXCxL8ca32LSWW7940fwmt6vGHgTn",
    "content": [
      {"type": "text", "content": sss}
    ]
  });
  data.add({
    "name": "You",
    "icon":
        "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSEzcd0SCyC8nqruJxNvPQNx6KlXDR3s9IntFNZs904i9OwJGvS",
    "content": [
      {
        "type": "video",
        "content":
            "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
      }
    ]
  });
  data.add({
    "name": "We",
    "icon":
        "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQZWxG4gOgEs_csSqdaj_OugrYSTjEpmyS6U8OFf6W92Lui5QUp",
    "content": [
      {
        "type": "video",
        "content":
            "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
      }
    ]
  });
  data.add({
    "name": "who",
    "icon":
        "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTqP-VlRrnX3FItUslani17KKDcQWYFPAzUCroSM25HrdVVR5Sv",
    "content": [
      {
        "type": "video",
        "content":
            "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
      }
    ]
  });
  return data;
}

var _cards = foo();

class HoriView extends StatelessWidget {
  HoriView();

  @override
  Widget build(BuildContext context) {
    return new SizedBox(
      height: 150.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _cards.length,
        itemExtent: 100.0,
        itemBuilder: (context, index) {
          var item = _cards[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
            child: GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(
                '/MV',
                arguments: foo(),
              ),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      item["icon"],
                    ),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black26,
                      BlendMode.darken,
                    ),
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    //add progress info
                    /* Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://iisy.fi/wp-content/uploads/2018/08/user-profile-male-logo.jpg',
                        ),
                        radius: 14.0,
                      ),
                    ),
                  ),
                  */
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        item["name"],
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// to do bookmrks

class VerticalView extends StatelessWidget {
  VerticalView(this.use);
  final bool use;
  @override
  Widget build(BuildContext context) {
    return new SizedBox(
      height: 500.0,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: _cards.length,
        //itemExtent: 100.0,
        itemBuilder: (context, index) {
          var item = _cards[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
            child: GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(
                '/MV',
                arguments: _cards,
              ),
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: double.maxFinite,
                      height: 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(item["icon"]),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(1.0),
                      child: Center(
                        child: Text(item["name"]),
                      ),
                    ),
                    Container(
                        child: this.use
                            ? Center(
                                child: Text("progress 50%"),
                              )
                            : null),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const MyCustomAppBar({
    Key key,
    @required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            decoration: new BoxDecoration(
              borderRadius: new BorderRadius.horizontal(),
              color: Colors.green[100],
            ),
            width: double.infinity,
            height: 58,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RawMaterialButton(
                  onPressed: null,
                  child: Icon(Icons.notifications, color: Colors.yellow),
                  shape: new CircleBorder(),
                  constraints:
                      new BoxConstraints(minHeight: 50.0, minWidth: 50.0),
                ),
                Text("AppName"),
                Icon(
                  Icons.flare,
                  color: Colors.green,
                  size: 50,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
