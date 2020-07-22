import 'package:RACR/stores/progress_store.dart';
import 'package:RACR/ui/app_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import "package:percent_indicator/linear_percent_indicator.dart";
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:audioplayers/audioplayers.dart';
import './modules_drawer.dart';
import '../stores/module_page_store.dart';
import '../widgets/content_viewer.dart';
import '../utils/progress.dart';
import '../utils/content_fetch.dart';
import '../customIcons/irj_logo_icons_icons.dart';

//import '../stores/module_view_store.dart';

class ModulesView extends StatelessWidget {
  ModulesView(this.args);
  final args;
  @override
  Widget build(BuildContext context) {
    print('butidling topic bar--------------------------------');
    var storeP = Provider.of<PageStore>(context);
    var progressStore = Provider.of<ProgressStore>(context);
    return SafeArea(
        child: Scaffold(
      drawer: MyDrawer(
          this.args["items"], this.args["icon"], this.args['id'], context),
      appBar: MyCustomAppBar(50, this.args["name"]),
      body: Observer(
          builder: (_) => Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                    TopicBar(
                        50, progressStore.getModuleProgress, this.args['id']),
                    Expanded(
                      child: Scrollbar(
                        isAlwaysShown: true,
                        child: MContent(this.args['id'], storeP.getTopicId,
                            storeP.getArticleId, storeP.content),
                      ),
                    ),
                  ]))),
    ));
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
                                  color: Colors.white),
                              shape: new CircleBorder(),
                              constraints: new BoxConstraints(
                                  minHeight: 7.0, minWidth: 7.0),
                            )),
                        Padding(
                            padding: EdgeInsets.only(bottom: 3.0,),
                            child: RawMaterialButton(
                              onPressed: () async =>
                                  Navigator.of(context).pushNamed(
                                '/ML',
                                arguments: await getModelsFromDB(),
                              ),
                              child: new Icon(FeatherIcons.grid,
                                  color: Colors.white),
                              constraints: new BoxConstraints(
                                  minHeight:7.0, minWidth: 7.0),
                            )),
                        // new NotificationWidget(Colors.white)
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
                    IrjLogoIcons.irjlogowhite,
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

class TopicBar extends StatefulWidget {
  final Map<int, double> percent;
  final double height;
  final int modelId;
  TopicBar(this.height, this.percent, this.modelId);
  @override
  _TopicBar createState() => _TopicBar(this.height, this.percent, this.modelId);
}

class _TopicBar extends State<TopicBar> {
  AudioPlayer advancedPlayer = AudioPlayer();
  _TopicBar(this.height, this.percent, this.modelId) : super();
  final Map<int, double> percent;
  final double height;
  final int modelId;
  var myDarkGrey = Color(0xff605E5E);
  var myDarkBlue = Color(0xff085576);
  var mylightBlue = Color(0xff8AD0EE);
  var myDarkBlueOverlay = Color(0x55085576);
  String audioButtonState = 'toPlay';
  List audiofilesState = new List();

  playArticleAudio(BuildContext context, List audioFiles) async {
    if (audioFiles.length == audiofilesState.length) {
      var state;
      if (audiofilesState.length == 0) {
        state = false;
      } else {
        state = true;
      }
      for (var i = 0; i < audiofilesState.length; i++) {
        state = state && audiofilesState[i];
      }

      if (state) {
        setState(() {
          audioButtonState = 'toPlay';
        });
        return;
      } else {
        if (audioButtonState == 'playing') {
          await advancedPlayer.pause();
          setState(() {
            audioButtonState = 'paused';
          });
        } else if (audioButtonState == 'paused') {
          await advancedPlayer.resume();
          setState(() {
            audioButtonState = 'playing';
          });
        }
      }
    } else {
      if (audioButtonState == 'playing') {
        await advancedPlayer.pause();
        setState(() {
          audioButtonState = 'paused';
        });
      } else if (audioButtonState == 'paused') {
        await advancedPlayer.resume();
        setState(() {
          audioButtonState = 'playing';
        });
      } else {
        if (audioFiles.length == 0) {
          Alert(
              context: context,
              title: "لا يوجد ملف صوتي لهذه المقالة",
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
        } else {
          var currentFile = '';
          var currentFileIndex = 0;
          for (var i = 0; i < audioFiles.length; i++) {
            if (audiofilesState.length == 0 || audiofilesState.length <= i) {
              currentFile = audioFiles[i];
              currentFileIndex = i;
              audiofilesState.add(false);
              break;
            }
          }
          await advancedPlayer.play(currentFile).then((result) {
            if (result == 1) {
              setState(() {
                audioButtonState = 'playing';
              });
              advancedPlayer.onPlayerStateChanged.listen((AudioPlayerState s) {
                if (s == AudioPlayerState.COMPLETED) {
                  if (currentFileIndex <= audioFiles.length - 1) {
                    setState(() => audioButtonState = 'toPlay');
                    audiofilesState[currentFileIndex] = true;
                    playArticleAudio(context, audioFiles);
                  }
                }
              });
            }
          });
        }
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    advancedPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    print('hello buitdlsdfssssssssssssssssssssssssss');
    var pageStore = Provider.of<PageStore>(context);
    double progress = 0.0;
    percent.forEach((key, value) {
      if (key == modelId) {
        print('sssssssssssssssssssssssssspercent');
        print(value);
        progress = value;
      }
    });

    return Observer(
        builder: (_) => Container(
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
                          child: new Icon(FeatherIcons.menu,
                              color: myDarkBlue, size: 20),
                          shape: new CircleBorder(),
                          constraints: new BoxConstraints(
                              minHeight: 10.0, minWidth: 10.0),
                        )),
                  ),
                  Container(
                      width: 250,
                      child: new LinearPercentIndicator(
                          width: 250,
                          lineHeight: 20.0,
                          padding: EdgeInsets.all(0),
                          center: Text(
                            (progress * 100).toStringAsFixed(2) + "%",
                            style: GoogleFonts.lateef(
                                textStyle: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.white,
                                    height: 1.1)),
                          ),
                          linearStrokeCap: LinearStrokeCap.roundAll,
                          backgroundColor: mylightBlue,
                          progressColor: myDarkBlue,
                          percent: progress)),
                  Align(
                    alignment: Alignment.centerRight,
                    child: RawMaterialButton(
                      onPressed: () =>
                          playArticleAudio(context, pageStore.getAudioFiles),
                      child: Icon(
                          audioButtonState == 'playing'
                              ? Icons.pause
                              : FeatherIcons.volume2,
                          color: myDarkBlue,
                          size: 24),
                      shape: new CircleBorder(),
                      constraints:
                          new BoxConstraints(minHeight: 20.0, minWidth: 20.0),
                    ),
                  )
                ],
              ),
            ));
  }
}
