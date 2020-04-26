import 'package:RACR/ui/app_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import "package:percent_indicator/linear_percent_indicator.dart";
import './modules_drawer.dart';
import '../stores/module_page_store.dart';
import '../widgets/test2.dart';
import '../utils/progress.dart';
//import '../stores/module_view_store.dart';

class ModulesView extends StatelessWidget {
  ModulesView(this.args);
  final args;
  @override
  Widget build(BuildContext context) {

    var storeP = Provider.of<PageStore>(context);
    double progress = 0.0;
    return SafeArea(
      child: Scaffold(
          drawer: MyDrawer(this.args["items"], this.args["icon"],this.args['id']),
          appBar: MyCustomAppBar(50, this.args["name"]),
          body: Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                 Observer(
                      builder: (_) =>
                       FutureBuilder<double>(
              future: getModelProgressPercent(this.args['id']),
              builder: (context, AsyncSnapshot<double> snapshot) {
                if (snapshot.hasData) {
                  progress = snapshot.data;
                }
                return TopicBar(50, 
                    progress,
                    );})),
                Expanded(
                  child: Center(
                    child: Observer(
                      builder: (_) => Testing(contentList: storeP.pageNum),
                    ),
                  ),
                ),
              ]))),
    );
  }
}

class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  MyCustomAppBar(this.height, this.modName) : super();

  final double height;
  final modName;
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
            modName,
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

class TopicBar extends StatelessWidget implements PreferredSizeWidget {
  TopicBar(this.height, this.percent) : super();
  final percent;
  final double height;
  final myDarkGrey = Color(0xff605E5E);
  final myDarkBlue = Color(0xff085576);
  final mylightBlue = Color(0xff8AD0EE);

  @override
  Widget build(BuildContext context) {
    // final barStore = Provider.of<ViewStore>(context);

    return Container(
      decoration: new BoxDecoration(
        color: Colors.white,
      ),
      width: double.maxFinite,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Padding(
                padding: EdgeInsets.only(bottom: 3.0),
                child: RawMaterialButton(
                  onPressed: () => Scaffold.of(context).openDrawer(),
                  child:
                      new Icon(FeatherIcons.menu, color: myDarkBlue, size: 20),
                  shape: new CircleBorder(),
                  constraints:
                      new BoxConstraints(minHeight: 10.0, minWidth: 10.0),
                )),
          ),
          Container(
              width: 250,
              child: new LinearPercentIndicator(
                  width: 250,
                  lineHeight: 20.0,
                  padding: EdgeInsets.all(0),
                  center: Text(
                    (percent * 100).toString() + "%",
                    style: GoogleFonts.lateef(
                        textStyle: TextStyle(
                            fontSize: 20.0, color: Colors.white, height: 1.1)),
                  ),
                  linearStrokeCap: LinearStrokeCap.roundAll,
                  backgroundColor: mylightBlue,
                  progressColor: myDarkBlue,
                  percent: percent)),
          Align(
            alignment: Alignment.centerRight,
            child: RawMaterialButton(
              onPressed: null,
              child: Icon(FeatherIcons.volume2, color: myDarkBlue, size: 24),
              shape: new CircleBorder(),
              constraints: new BoxConstraints(minHeight: 20.0, minWidth: 20.0),
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
