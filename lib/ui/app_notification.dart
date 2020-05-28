import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:device_info/device_info.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:disk_space/disk_space.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:connectivity/connectivity.dart';
import '../stores/progress_store.dart';
import '../utils/progress.dart';
import '../utils/content_fetch.dart';

class NotificationWidget extends StatefulWidget {
  final Color color;
  NotificationWidget(this.color);

  @override
  _NotificationState createState() => _NotificationState(color);
}

class _NotificationState extends State<NotificationWidget>
    with TickerProviderStateMixin {
  final myDarkGrey = Color(0xff605E5E);
  final myDarkBlue = Color(0xff085576);
  final myDarkBlueOverlay = Color(0x55085576);
  final mylightBlue = Color(0xff8AD0EE);
  var customColor = Color(0xff605E5E);

  bool downloading = false;
  String progressString = '';
  double progressValue = 0.0;
  bool showFreeSpace = false;

  double _platformVersion = 0; // for diskspace
  _NotificationState(this.customColor);

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  //Progress overlay
  OverlayState overlayState;
  OverlayEntry overlayForProgress;
  OverlayEntry progressBarForFile;

  // Animation
  AnimationController _controller;
  Tween<double> _tween = Tween(begin: 0.2, end: 1);

  bool hasNotification = false;
  var notificationIcon;

  //Check if the Shared Prefereces has the notification key
  void checkNotificationExistInSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('NCDPNotification') != null) {
      setState(() {
        hasNotification = true;
        notificationIcon = Icons.notifications;
      });
    } else {
      setState(() {
        hasNotification = false;
        notificationIcon = Icons.notifications_none;
      });
    }
  }

  // Save Notification in the Shared Preferences.
  void saveNotificationInSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('NCDPNotification', true);
    setState(() {
      hasNotification = true;
      notificationIcon = Icons.notifications;
    });
  }

  void removeNotificationFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('NCDPNotification');
    setState(() {
      hasNotification = false;
      notificationIcon = Icons.notifications_none;
    });
  }

  Future<void> initPlatformState() async {
    double platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await DiskSpace.getFreeDiskSpace;
    } on PlatformException {
      platformVersion = 0;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  void initState() {
    super.initState();
    // for diskspace measurements
    initPlatformState();
    //Check if the Shared Prefereces has the notification key
    checkNotificationExistInSharedPreferences();
    //Elastic Animation
    _controller = AnimationController(
        duration: const Duration(milliseconds: 700), vsync: this);
    _controller.repeat(reverse: true);
    // firebase Messaging Cloud configuration
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        //store in shared preferecns
        saveNotificationInSharedPreferences();
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        saveNotificationInSharedPreferences();
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        saveNotificationInSharedPreferences();
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });

    String deviceId;
    getDeviceDetails().then((details) {
      deviceId = details[2].toString();
    });

    _firebaseMessaging.getToken().then((String token) async {
      assert(token != null);
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.mobile) {
        print('connected');
        SharedPreferences prefs = await SharedPreferences.getInstance();
        if (prefs.getString('NCDPDeviceToken') == null) {
          http.post(
            'http://162.247.76.211:3000/Articles/Registration',
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'id': deviceId,
              'token': token,
              'regDate':
                  DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now())
            }),
          );

          prefs.setString('NCDPDeviceToken', token);
        } else {
          if (prefs.getString('NCDPDeviceToken') != token) {
            // TODO update in db
            http.post(
              'http://162.247.76.211:3000/Articles/Registration', // CHANGE THIS LINE
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body:
                  jsonEncode(<String, String>{'id': deviceId, 'token': token}),
            );
            prefs.setString('NCDPDeviceToken', token);
          }
        }
      }
    });
  }

  Future<List<String>> getDeviceDetails() async {
    String deviceName;
    String deviceVersion;
    String identifier;
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceName = build.model;
        deviceVersion = build.version.toString();
        identifier = build.androidId; //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        deviceName = data.name;
        deviceVersion = data.systemVersion;
        identifier = data.identifierForVendor; //UUID for iOS
      }
    } on PlatformException {
      print('Failed to get platform version');
    }

//if (!mounted) return;
    return [deviceName, deviceVersion, identifier];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(NotificationWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    checkNotificationExistInSharedPreferences();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    checkNotificationExistInSharedPreferences();
  }

  void handleNoContent(context) {
    Alert(
        context: context,
        title: "لا يوجد محتوى جديد",
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

  void handleNewContent(BuildContext context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      Alert(
          context: context,
          title: "هل ترغب بتنزيل المحتوى الجديد؟",
          buttons: [
            DialogButton(
                child: Text(
                  "تنزيل",
                  style: TextStyle(color: myDarkBlue, fontSize: 18),
                ),
                onPressed: () => checkDownload(context),
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
    } else {
      Alert(
          context: context,
          title: "لا يوجد اتصال بالانترنت",
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
  }

  void showNoInternetAlert(BuildContext context) {
    Alert(
        context: context,
        title: "حدثت مشكلة الرجاء التأكد من اتصالك بالانترنت وحاول مرة أخرى",
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

  void checkDownload(BuildContext context) async {
    // IF THE SPACE IS GOOD THEN MOVE OT THE DOWNLOAD PROGRESS PAGE AND DOWNLAD
    // ELSE PROMPT AN ALERT BOX TO EITHER DOWNLOAD ONLY THE TEXT VERSION OR TO FREE SPACE
    Navigator.of(context).pop();
    overlayState = Overlay.of(context);
    overlayForProgress = OverlayEntry(
        builder: (context) => SizedBox.expand(
                child: Container(
              color: myDarkBlueOverlay,
            )));

    progressBarForFile =
        OverlayEntry(builder: (context) => ProgressDownload());
    overlayState.insert(overlayForProgress);
    overlayState.insert(progressBarForFile);
    double fileSize = await checkFileSizeBeforeDownload();
    if (fileSize == 0) {
      showNoInternetAlert(context);
    } else {
      if (fileSize > _platformVersion * 1000) {
        // remove this alert and show the free some sapce alert

        Alert(
            context: context,
            title: "الرجاء تحرير بعض المساحة علي الجهاز لتنزيل الملف بنجاح",
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
        await downloadJsonFile();
      }
    }
  }

  Future<double> checkFileSizeBeforeDownload() async {
    double size = 0;
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      var fileUrl = 'http://162.247.76.211:3000/JSONFile';
      http.Response response = await http.head(fileUrl);

      try {
        size = double.parse(response.headers['content-length']);
      } catch (error) {
        print('error finiding the size of the file before downloading it');
        return 0;
      }
    }
    return size;
  }

  // Future<void> openFile() async {
  //   var dir = await getExternalStorageDirectory();
  //   final filePath = "${dir.path}/x.json";
  //   await OpenFile.open(filePath);
  // }

  Future<void> downloadJsonFile() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      var progressStore = Provider.of<ProgressStore>(context,listen: false);

      var fileUrl = 'http://162.247.76.211:3000/JSONFile';
      var dio = Dio();
      dio.interceptors.add(LogInterceptor());
      try {
        var dir = await getApplicationDocumentsDirectory();

        await dio.download(fileUrl, "${dir.path}/newContent.json",
            onReceiveProgress: (rec, total) {
          print("Rec: $rec , Total: $total");

          setState(() {
            downloading = true;
            progressValue = (rec / total);
            print('setting');
            progressStore.setProgress(progressValue);
            progressString = (progressValue * 100).toStringAsFixed(2) + "%";
          });
        });
        progressBarForFile.remove();
        overlayForProgress.remove();
        setState(() {
          downloading = false;
          hasNotification = false;
        });
//TODO ADD NEW CONTENT TO CONTENT FILE AND PROGRESS FILE
print('addddddddddddddddddddddddddddddddddddddddddddddddddddddd');
       await addNewContentToContentFile();
      await  addNewContentToProgressFile();
        Alert(
            context: context,
            title: "تم التنزيل بنجاح",
            buttons: [
              // DialogButton(
              //     child: Text(
              //       "الرابط",
              //       style: TextStyle(color: myDarkBlue, fontSize: 18),
              //     ),
              //     onPressed: () => openFile(),
              //     color: mylightBlue),
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
            progressStore.setProgress(0.0);
      } catch (error) {
        print('File downloading error: ' + error);
        progressBarForFile.remove();
        overlayForProgress.remove();
        Alert(
            context: context,
            title: "حدث خطأ أثناء التحميل الرجاء المحاولة مرة أخرى",
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
    } else {
      progressBarForFile.remove();
      overlayForProgress.remove();
      showNoInternetAlert(context);
    }
  }

  @override
  Widget build(BuildContext context) {

    return !hasNotification
        ? RawMaterialButton(
            onPressed: () => handleNoContent(context),
            child: Icon(Icons.notifications_none, color: customColor),
            shape: new CircleBorder(),
            constraints: new BoxConstraints(minHeight: 10.0, minWidth: 10.0),
          )
        : ScaleTransition(
            scale: _tween.animate(
                CurvedAnimation(parent: _controller, curve: Curves.elasticOut)),
            child: RawMaterialButton(
              onPressed: () => handleNewContent(context),
              child: Icon(Icons.notifications, color: customColor),
              shape: new CircleBorder(),
              constraints: new BoxConstraints(minHeight: 10.0, minWidth: 10.0),
            ));
  }
}

class ProgressDownload extends StatelessWidget {
 
  final myDarkGrey = Color(0xff605E5E);
  final myDarkBlue = Color(0xff085576);
  final myDarkBlueOverlay = Color(0x55085576);
  final mylightBlue = Color(0xff8AD0EE);


  @override
  Widget build(BuildContext context) {
    print('building progress download ..............');
    var progressStore = Provider.of<ProgressStore>(context);
    return Observer(
        builder: (_) => Container(
            margin: EdgeInsets.fromLTRB(30.0, 0, 30.0, 0.0),
            width: 250,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'يتم البحث عن المحتوى وتنزيله...',
                    style: GoogleFonts.lateef(
                        textStyle: TextStyle(
                            fontSize: 28.0, color: Colors.white, height: 1)),
                  ),
                  LinearPercentIndicator(
                      lineHeight: 50.0,
                      padding: EdgeInsets.all(0),
                      center: Text(
                        (progressStore.getProgress * 100).toStringAsFixed(2) +
                            "%",
                        style: GoogleFonts.lateef(
                            textStyle: TextStyle(
                                fontSize: 28.0,
                                color: Colors.white,
                                height: 1)),
                      ),
                      linearStrokeCap: LinearStrokeCap.butt,
                      backgroundColor: mylightBlue,
                      progressColor: myDarkBlue,
                      percent: progressStore.getProgress)
                ])));
  }
}
