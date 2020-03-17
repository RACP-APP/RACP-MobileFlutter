import 'package:flutter/material.dart';
import '../widgets/video_p.dart';
import 'package:video_player/video_player.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';

class Landing extends StatefulWidget {
  Landing({Key key}) : super(key: key);

  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  final myDarkGrey = Color(0xff605E5E);
  final myDarkBlue = Color(0xff085576);
  final mylightBlue = Color(0xff8AD0EE);
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
                    child: RawMaterialButton(
                      onPressed: null,
                      child: Icon(Icons.notifications_none, color: myDarkGrey),
                      shape: new CircleBorder(),
                      constraints:
                          new BoxConstraints(minHeight: 24.0, minWidth: 24.0),
                    ),
                  ),
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
              padding: EdgeInsets.symmetric(vertical:15.0),
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
            Padding(
              padding: EdgeInsets.symmetric(vertical:21.0),
              child: Container(
                child: Center(
                    child: Text(
                  "يتضمن هذا التطبيق العديد  من \n المواضيع التي تهم الأمهات سواء \n على صعيد الحياة الشخصية أو على \n صعيد صحة الطفل وتعليمه",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lateef(
                      textStyle: TextStyle(
                          fontSize: 28.0, color: Colors.white, height: 1)),
                )),
              ),
            ),
            Container(
              padding:EdgeInsets.only(bottom: 32.0),
              child: Center(
                child: RaisedButton(
                  padding: EdgeInsets.all(4.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0),
                  ),
                  color: mylightBlue,
                  onPressed: () => Navigator.of(context).pushNamed('/ML'),
                  child: Container(
                      width: 135,
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
                                      minHeight: 40.0, minWidth: 40.0),
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
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                width: double.infinity,
                height: 50,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                      icon: new Icon(FeatherIcons.facebook,color: myDarkGrey),
                      onPressed: () async =>
                          await launch("https://www.facebook.com"),
                    ),
                     IconButton(
                      // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                      icon: new Icon(FeatherIcons.linkedin,color: myDarkGrey),
                      onPressed: () async =>
                          await launch("https://www.linkedin"),
                    ),
                    IconButton(
                      // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                      icon: new Icon(FeatherIcons.twitter,color: myDarkGrey),
                      onPressed: () async =>
                          await launch("https://www.twitter.com"),
                    ), IconButton(
                      // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                      icon: new Icon(FeatherIcons.instagram,color: myDarkGrey),
                      onPressed: () async =>
                          await launch("https://www.instagram.com"),
                    ),
                    
                    IconButton(
                      // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                      icon: FaIcon(FontAwesomeIcons.whatsapp,color: myDarkGrey),
                      onPressed: () async => await launch(
                          "https://api.whatsapp.com/send?phone=962787097853"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
