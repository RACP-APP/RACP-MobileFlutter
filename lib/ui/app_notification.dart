import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationWidget extends StatefulWidget {
  Color color;
  NotificationWidget(color) {
    color = color;
  }

  @override
  _NotificationState createState() => _NotificationState(color);
}

class _NotificationState extends State<NotificationWidget> {

  var customColor = Color(0xff605E5E);

   _NotificationState(color) {
    customColor = color;
  }

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool hasNotification = false;
  var notificationIcon;
 
  //Check if the Shared Prefereces has the notification key
  void checkNotificationExistInSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('NCDPNotification')) {
      setState(() {
        hasNotification = true;
        notificationIcon = Icons.notifications;
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

  @override
  void initState() {
    super.initState();

    //Check if the Shared Prefereces has the notification key
    checkNotificationExistInSharedPreferences();

    // firebase Messaging Cloud configuration
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('*****************onMessage**************************');
        //store in shared preferecns
        saveNotificationInSharedPreferences();
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('*****************onLaunch**************************');
        print("onLaunch: $message");
        saveNotificationInSharedPreferences();
      },
      onResume: (Map<String, dynamic> message) async {
        print('*****************onResume**************************');
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
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      print('*****************token**************************');
      print(token);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (hasNotification) {
      print('************we hav a new notification************************');
      notificationIcon = Icons.notifications;
    } else {
      print('*********** no a new notification************************');
      notificationIcon = Icons.notifications_none;
    }
    return RawMaterialButton(
      onPressed: () => removeNotificationFromSharedPreferences(),
      child: Icon(notificationIcon, color: customColor),
      shape: new CircleBorder(),
      constraints: new BoxConstraints(minHeight: 24.0, minWidth: 24.0),
    );
  }
}
