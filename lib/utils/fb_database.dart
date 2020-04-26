import 'dart:async';
import 'dart:io' show Platform;

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

Future<void> saveToFbDatabase() async {
  final FirebaseApp app = await FirebaseApp.configure(
    name: 'ncdb',
    options:  const FirebaseOptions(
            googleAppID: '1:375025496206:android:fb9017150232ae37a759df',
            apiKey: 'AIzaSyCaHF2NN9eptxLXE9PjTZgDZdJuFjTxyTo',
            databaseURL: 'https://ndpc-c5c37.firebaseio.com/',
          ),
  );
 
}