import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/video_p.dart';
import '../utils/content_fetch.dart';
import '../ui/app_notification.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../customIcons/irj_logo_icons_icons.dart';

class Landing extends StatefulWidget {
  Landing({Key key}) : super(key: key);

  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  static final myDarkGrey = Color(0xff605E5E);
  final myDarkBlue = Color(0xff085576);
  final mylightBlue = Color(0xff8AD0EE);
  final myDarkBlueOverlay = Color(0x55085576);
  bool isLoading = false;
  Widget startLearningStatus = Transform.rotate(
      angle: 1.0,
      child: RawMaterialButton(
        onPressed: null,
        child: Icon(Icons.play_arrow, color: myDarkGrey, size: 40),
        shape: new CircleBorder(),
        constraints: new BoxConstraints(minHeight: 20.0, minWidth: 40.0),
      ));
  getHelpApplication() {
    Alert(
        context: context,
        title:
            "سوف يتم توجيهك لتحميل تطبيق يوفر المساعدة في حال التعرض للعنف مع ملاحظة أن هذا التطبيق تحت رعاية جهة أخري",
        buttons: [
          DialogButton(
              child: Text(
                "تنزيل التطبيق",
                style: TextStyle(color: myDarkBlue, fontSize: 18),
              ),
              onPressed: () => goToHelpApp(),
              color: mylightBlue),
        ],
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

  goToHelpApp() async {
    await launch(
        "https://play.google.com/store/apps/details?id=jo.dwt.sgbv&hl=ar");
  }

  @override
  void dispose() {
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: new BoxDecoration(
          color: myDarkBlue,
        ),
        child: ListView(
          children: <Widget>[
            Container(
              decoration: new BoxDecoration(
                color: Colors.white,
              ),
              width: double.infinity,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: new NotificationWidget(myDarkGrey))),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Icon(
                            IrjLogoIcons.irglogo,
                            color: myDarkGrey,
                            size: 30,
                          )))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              child: Container(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: Center(
                  child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                        "أهلاً بك ...",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lateef(
                            textStyle: TextStyle(
                                fontSize: 30.0,
                                color: Colors.white,
                                height: 1.1)),
                      )),
                ),
              ),
            ),
            Container(
              child: Container(
                width: double.maxFinite,
                child: ChewieListItem(
                  videoPlayerController:
                      VideoPlayerController.asset('assets/videos/intro.mp4'),               
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(vertical: 25.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        child: Center(
                          child: RaisedButton(
                            padding: EdgeInsets.all(12.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20.0),
                            ),
                            color: mylightBlue,
                            onPressed: () async =>
                                Navigator.of(context).pushNamed('/INTRO'),
                            child: Container(
                                width: 190,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                          padding: EdgeInsets.only(right: 8.0),
                                          child: Text(
                                            "مرحباً",
                                            textAlign: TextAlign.start,
                                            style: GoogleFonts.lateef(
                                                textStyle: TextStyle(
                                                    fontSize: 28.0,
                                                    color: myDarkGrey,
                                                    height: 1)),
                                          ))
                                    ])),
                          ),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(top: 15.0, bottom: 10.0),
                          child: Center(
                            child: RaisedButton(
                              padding: EdgeInsets.all(4.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(20.0),
                              ),
                              color: mylightBlue,
                              onPressed: () async {
                                setState(() {
                                  startLearningStatus =
                                      CircularProgressIndicator();
                                });
                                getModelsFromDB().then((modules) {
                                  // stop loading
                                  setState(() {
                                    startLearningStatus = Transform.rotate(
                                        angle: 1.0,
                                        child: RawMaterialButton(
                                          onPressed: null,
                                          child: Icon(Icons.play_arrow,
                                              color: myDarkGrey, size: 40),
                                          shape: new CircleBorder(),
                                          constraints: new BoxConstraints(
                                              minHeight: 20.0, minWidth: 40.0),
                                        ));
                                  });
                                  Navigator.of(context).pushNamed(
                                    '/ML',
                                    arguments: modules,
                                  );
                                });
                              },
                              child: Container(
                                  width: 200,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        startLearningStatus,
                                        Padding(
                                            padding:
                                                EdgeInsets.only(right: 8.0),
                                            child: Text(
                                              "ابدأ التعلم",
                                              textAlign: TextAlign.start,
                                              style: GoogleFonts.lateef(
                                                  textStyle: TextStyle(
                                                      fontSize: 28.0,
                                                      color: myDarkGrey,
                                                      height: 1)),
                                            ))
                                      ])),
                            ),
                          )),
                      Container(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Center(
                          child: RaisedButton(
                            padding: EdgeInsets.all(4.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20.0),
                            ),
                            color: mylightBlue,
                            onPressed: () async => getHelpApplication(),
                            child: Container(
                                width: 200,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                          padding: EdgeInsets.only(right: 8.0),
                                          child: Text(
                                            "للمساعدة ",
                                            textAlign: TextAlign.start,
                                            style: GoogleFonts.lateef(
                                                textStyle: TextStyle(
                                                    fontSize: 28.0,
                                                    color: myDarkGrey,
                                                    height: 1)),
                                          ))
                                    ])),
                          ),
                        ),
                      ),
                      Container(
                        child: Center(
                          child: RaisedButton(
                            padding: EdgeInsets.all(12.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20.0),
                            ),
                            color: mylightBlue,
                            onPressed: () async =>
                                Navigator.of(context).pushNamed('/AboutUs'),
                            child: Container(
                                width: 190,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                          padding: EdgeInsets.only(right: 8.0),
                                          child: Text(
                                            "من نحن",
                                            textAlign: TextAlign.start,
                                            style: GoogleFonts.lateef(
                                                textStyle: TextStyle(
                                                    fontSize: 28.0,
                                                    color: myDarkGrey,
                                                    height: 1)),
                                          ))
                                    ])),
                          ),
                        ),
                      ),
                    ])),
          ],
        ),
      ),
    );
  }
}
