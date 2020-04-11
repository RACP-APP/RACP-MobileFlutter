import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import './utils/content_fetch.dart';
import 'utils/route_generator.dart';
import './stores/module_view_store.dart';
import './stores/drawer_store.dart';
import './stores/module_page_store.dart';
import './stores/notification_store.dart';
import './ui/landing_page.dart';

void main() async {
//   
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize();
  await fetchContent();
  runApp(new MyApp());
}

// checkNotification(BuildContext context) {
//   final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
//   final appNotification = Provider.of<AppNotification>(context);

//   firebaseMessaging.configure(
//     onMessage: (Map<String, dynamic> message) async {
//       // make the notification icon orange ???
//       print(message);
//       appNotification.changeNotificationState();
//     },
//   );
// }

class MyApp extends StatelessWidget {
  final myDarkGrey = Color(0xff605E5E);
  final myDarkBlue = Color(0xff085576);

  
  // var tokenId;

//   Future<String> getUserToken() async {

//     await firebaseMessaging.getToken().then((token) {
//       print('***********************************************************************************');
//       print(token);
//       return token;
//     });
//   }

//   Future<void> getToken() async {
//     tokenId = await getUserToken();
//   }
//  await getToken();
// print("token " + tokenId);

  @override
  Widget build(BuildContext context) {
   
    return MultiProvider(
      providers: [
        Provider<ViewStore>(create: (_) => ViewStore()),
        Provider<DrawerStore>(create: (_) => DrawerStore()),
        Provider<PageStore>(create: (_) => PageStore()),
        ChangeNotifierProvider<AppNotification>(
            create: (_) => AppNotification()),
        // FutureProvider<bool>(create:(_) =>  AppNotification().checkNotification() , catchError: (context,error){print(error.toString())} )
      ],
      child: new MaterialApp(
        title: 'الحياة والطفل',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          backgroundColor: myDarkBlue,
          body: Landing(),
          bottomNavigationBar: Container(
            width: double.infinity,
            height: 50,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                  icon: new Icon(FeatherIcons.facebook, color: myDarkGrey),
                  onPressed: () async =>
                      await launch("https://www.facebook.com"),
                ),
                IconButton(
                  // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                  icon: new Icon(FeatherIcons.linkedin, color: myDarkGrey),
                  onPressed: () async => await launch("https://www.linkedin"),
                ),
                IconButton(
                  // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                  icon: new Icon(FeatherIcons.twitter, color: myDarkGrey),
                  onPressed: () async =>
                      await launch("https://www.twitter.com"),
                ),
                IconButton(
                  // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                  icon: new Icon(FeatherIcons.instagram, color: myDarkGrey),
                  onPressed: () async =>
                      await launch("https://www.instagram.com"),
                ),
                IconButton(
                  // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                  icon: FaIcon(FontAwesomeIcons.whatsapp, color: myDarkGrey),
                  onPressed: () async => await launch(
                      "https://api.whatsapp.com/send?phone=962787097853"),
                ),
              ],
            ),
          ),
        ),
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
