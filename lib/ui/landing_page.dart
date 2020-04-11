import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/video_p.dart';
import '../utils/content_fetch.dart';
import '../ui/app_notification.dart';

class Landing extends StatefulWidget {
  Landing({Key key}) : super(key: key);

  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  final myDarkGrey = Color(0xff605E5E);
  final myDarkBlue = Color(0xff085576);
  final mylightBlue = Color(0xff8AD0EE);
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: new BoxDecoration(
          color: myDarkBlue,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
                      child: NotificationWidget(Color(0xff605E5E))),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.flare,
                            color: myDarkGrey,
                            size: 30,
                          )))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              child: Container(
                child: Center(
                  child: Text(
                    " مرحبا بك في تطبيق\n التوعية حول الحياة و الطفل",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lateef(
                        textStyle: TextStyle(
                            fontSize: 36.0, color: Colors.white, height: 1.1)),
                  ),
                ),
              ),
            ),
            Container(
              child: Container(
                width: double.maxFinite,
                child: ChewieListItem(
                  videoPlayerController: VideoPlayerController.network(
                    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
                  ),
                ),
              ),
            ),
            Container(
                height: 240,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: Center(
                            child: Text(
                          "يتضمن هذا التطبيق العديد  من \n المواضيع التي تهم الأمهات ",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lateef(
                              textStyle: TextStyle(
                                  fontSize: 28.0,
                                  color: Colors.white,
                                  height: 1)),
                        )),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 20.0),
                        child: Center(
                          child: RaisedButton(
                            padding: EdgeInsets.all(4.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20.0),
                            ),
                            color: mylightBlue,
                            onPressed: () async =>
                                Navigator.of(context).pushNamed(
                              '/ML',
                              arguments: await stream(),
                            ),
                            child: Container(
                                width: 200,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Transform.rotate(
                                          angle: 1.0,
                                          child: RawMaterialButton(
                                            onPressed: null,
                                            child: Icon(Icons.play_arrow,
                                                color: myDarkGrey, size: 40),
                                            shape: new CircleBorder(),
                                            constraints: new BoxConstraints(
                                                minHeight: 40.0,
                                                minWidth: 40.0),
                                          )),
                                      Padding(
                                          padding: EdgeInsets.only(right: 8.0),
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
                        ),
                      ),
                    ])),
          ],
        ),
      ),
    );
  }
}
