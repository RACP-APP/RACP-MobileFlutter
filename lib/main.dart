import 'package:RACR/stores/progress_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import './utils/content_fetch.dart';
import 'utils/route_generator.dart';
import './stores/module_view_store.dart';
import './stores/drawer_store.dart';
import './stores/module_page_store.dart';
import './ui/landing_page.dart';
import './utils/anlaytics.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
//
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize();

  
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getBool('ncdpDbSet') == null) {
    print('there is no db **************');
    await fetchContent();

  }else {
    print('there is db ***********************');
  }
  await saveAnalyticsToServer();
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  final myDarkGrey = Color(0xff605E5E);
  final myDarkBlue = Color(0xff085576);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ViewStore>(create: (_) => ViewStore()),
        Provider<DrawerStore>(create: (_) => DrawerStore()),
        Provider<PageStore>(create: (_) => PageStore()),
        Provider<ProgressStore>(create: (_) => ProgressStore()),
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
                      await launch("https://www.facebook.com/408212529232733/"),
                ),
                // IconButton(
                //   // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                //   icon: new Icon(FeatherIcons.linkedin, color: myDarkGrey),
                //   onPressed: () async => await launch("https://www.linkedin"),
                // ),
                IconButton(
                  // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                  icon: new Icon(FeatherIcons.twitter, color: myDarkGrey),
                  onPressed: () async =>
                      await launch("https://twitter.com/Islamicreliefjo?s=08"),
                ),
                IconButton(
                  // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                  icon: new Icon(FeatherIcons.instagram, color: myDarkGrey),
                  onPressed: () async =>
                      await launch("https://instagram.com/islamic.relief.jo?igshid=fnbh5qkitrjg"),
                ),
                // IconButton(
                //   // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                //   icon: FaIcon(FontAwesomeIcons.whatsapp, color: myDarkGrey),
                //   onPressed: () async => await launch(
                //       "https://api.whatsapp.com/send?phone=962787097853"),
                // ),
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
