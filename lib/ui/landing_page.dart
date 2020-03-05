import 'package:flutter/material.dart';
import '../widgets/video_p.dart';
import 'package:video_player/video_player.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Landing extends StatefulWidget {
  Landing({Key key}) : super(key: key);

  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
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
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                child: Center(
                  child: Text(
                    "This app is here to help you! \nmake sure to get a sense for what its about\nby watching the following intro",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                child: Container(
                  child: Center(
                    child: Text("Introduction Video"),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                child: Container(
                  child: Center(
                    child: ChewieListItem(
                      videoPlayerController: VideoPlayerController.network(
                        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                child: Center(
                  child: RaisedButton(
                    padding: EdgeInsets.all(12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(8.0),
                    ),
                    color: Colors.blue[200],
                    onPressed: () => Navigator.of(context).pushNamed('/ML'),
                    child: Text(
                      "To view available modules\nand start learning tap here",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: Text(
                      "Make sure to keep up with the application's material\nby checking the notifications on the top right of this page\nhappy learning! and dont lose the motive to keep on engaging with the app",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: 58,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      IconButton(
                        // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                        icon: FaIcon(FontAwesomeIcons.facebook),
                        onPressed: () async =>
                            await launch("https://m.facebook.com/zuck"),
                      ),
                      Text("Contact info"),
                      IconButton(
                        // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                        icon: FaIcon(FontAwesomeIcons.whatsapp),
                        onPressed: () async => await launch(
                            "https://api.whatsapp.com/send?phone=962787097853"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
