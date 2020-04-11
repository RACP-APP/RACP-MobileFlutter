
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppNotification with ChangeNotifier{

  bool hasNotification = false;
var notificationIcon = Icons.notifications_none;
// Future<bool> checkNotification() {
//   final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

//   firebaseMessaging.configure(
//     onMessage: (Map<String, dynamic> message) async {
//       // make the notification icon orange ???
//       print(message);
//       changeNotificationState();
//     },
//   );
// }
  void changeNotificationState (bool val){
    hasNotification = val;
     if (hasNotification) {
          print(
              '************we hav a new notification************************');
          notificationIcon = Icons.notifications;
        } else {
          print('*********** no a new notification************************');
          notificationIcon = Icons.notifications_none;
        }
    print('*******************chaning state***********************');
    notifyListeners();
  }
 

} 