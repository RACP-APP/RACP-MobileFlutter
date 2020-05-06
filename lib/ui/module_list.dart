import 'package:RACR/stores/module_page_store.dart';
import 'package:flutter/material.dart';
import "package:percent_indicator/linear_percent_indicator.dart";
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../utils/progress.dart';
import 'app_notification.dart';

class ModulesList extends StatefulWidget {
  ModulesList(this.stuff);
  final stuff;

  @override
  _ModuleListState createState() => _ModuleListState();
}

class _ModuleListState extends State<ModulesList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MyCustomAppBar(height: 58),
        body: VerticalView(this.widget.stuff),
      ),
    );
  }
}

class Module extends StatelessWidget {
  final myDarkGrey = Color(0xff605E5E);
  final myDarkBlue = Color(0xff085576);
  final mylightBlue = Color(0xff8AD0EE);

  final String name;
  final String img;
  final double percent;

  Module(this.name, this.img, this.percent) : super();

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
        margin: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0),
        width: 250,
        height: 150,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                "https://firebasestorage.googleapis.com/v0/b/ncdp-270519.appspot.com/o/images%2Fexpress-js-png-5.png?alt=media&token=a746268e-1deb-4165-90de-f8692c9d5a38"),
            fit: BoxFit.cover,
          ),
          border: Border.all(
            color: myDarkBlue,
            width: 1,
          ),
        ),
      ),
      Container(
          margin: EdgeInsets.fromLTRB(30.0, 0, 30.0, 0.0),
          width: 250,
          child: new LinearPercentIndicator(
              width: 250,
              animation: true,
              animationDuration: 2000,
              lineHeight: 50.0,
              padding: EdgeInsets.all(0),
              center: Text(
                name,
                style: GoogleFonts.lateef(
                    textStyle: TextStyle(
                        fontSize: 28.0, color: Colors.white, height: 1)),
              ),
              linearStrokeCap: LinearStrokeCap.butt,
              backgroundColor: mylightBlue,
              progressColor: myDarkBlue,
              percent: percent)),
      Container(
          margin: EdgeInsets.all(5),
          width: 250,
          child: Center(
              child: Text(
            (percent * 100).toStringAsFixed(2) + "%",
            style: GoogleFonts.lateef(
                textStyle:
                    TextStyle(fontSize: 20.0, color: myDarkGrey, height: 1)),
          )))
    ]);
  }
}

class VerticalView extends StatelessWidget {
  VerticalView(this.stuff);
  final stuff;
  final myDarkGrey = Color(0xff605E5E);
  final myDarkBlue = Color(0xff085576);
  final mylightBlue = Color(0xff8AD0EE);
  double overallProgress = 0;
  double modelProgress = 0;
  @override
  Widget build(BuildContext context) {
    print(stuff);
    var pageStore = Provider.of<PageStore>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.all(10.0),
            child: FutureBuilder<double>(
                future: getOverallProgressPercent(),
                builder: (context, AsyncSnapshot<double> snapshot) {
                  if (snapshot.hasData) {
                    overallProgress = snapshot.data;
                  }
                  return new LinearPercentIndicator(
                    width: MediaQuery.of(context).size.width / 1.07,
                    animation: true,
                    lineHeight: 30.0,
                    animationDuration: 2000,
                    percent: overallProgress,
                    center: Text("مدى التقدم الكامل",
                        style: GoogleFonts.lateef(
                            textStyle: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                height: 1))),
                    linearStrokeCap: LinearStrokeCap.roundAll,
                    backgroundColor: mylightBlue,
                    progressColor: myDarkBlue,
                  );
                })),
        new Expanded(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: stuff.length,
            //itemExtent: 100.0,
            itemBuilder: (context, index) {
              var item = stuff[index];
              return FutureBuilder<double>(
                  future: getModelProgressPercent(item["ModelID"]),
                  builder: (context, AsyncSnapshot<double> snapshot) {
                    if (snapshot.hasData) {
                      modelProgress = snapshot.data;
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4.0, vertical: 4.0),
                      child: GestureDetector(
                          onTap: () {

                            Navigator.of(context).pushNamed(
                              '/MV',
                              arguments: {
                                "items": item["Topics"],
                                "icon": item["Icon"],
                                "name": item["Title"],
                                "progress": modelProgress,
                                "id": item["ModelID"]
                              },
                            );
                          },
                          child: Module(
                              item["Title"], item["Icon"], modelProgress)),
                    );
                  });
            },
          ),
        )
      ],
    );
  }
}

class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  MyCustomAppBar({
    Key key,
    @required this.height,
  }) : super(key: key);

  final myDarkGrey = Color(0xff605E5E);
  final myDarkBlue = Color(0xff085576);
  final mylightBlue = Color(0xff8AD0EE);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        color: myDarkBlue,
      ),
      width: 130,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(bottom: 3.0),
                            child: RawMaterialButton(
                              onPressed: () =>
                                  Navigator.of(context).pushNamed('/'),
                              child: new Icon(FeatherIcons.home,
                                  color: Colors.white, size: 20),
                              shape: new CircleBorder(),
                              constraints: new BoxConstraints(
                                  minHeight: 10.0, minWidth: 10.0),
                            )),
                        new NotificationWidget(Colors.white)
                      ]))),
          Container(
              child: Center(
                  child: Text(
            "المواضيع",
            style: GoogleFonts.lateef(
                textStyle:
                    TextStyle(fontSize: 25.0, color: Colors.white, height: 1)),
          ))),
          Align(
              alignment: Alignment.centerRight,
              child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.flare,
                    color: Colors.white,
                    size: 30,
                  )))
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
