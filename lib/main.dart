import 'package:flutter/material.dart';
import 'utils/route_generator.dart';

import 'package:flutter_downloader/flutter_downloader.dart';

import 'package:provider/provider.dart';
import './stores/module_view_store.dart';
import './stores/drawer_store.dart';

import './stores/module_page_store.dart';

import './ui/landing_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize();

  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ViewStore>(create: (_) => ViewStore()),
        Provider<DrawerStore>(create: (_) => DrawerStore()),
        Provider<PageStore>(create: (_) => PageStore()),
      ],
      child: new MaterialApp(
        title: 'Flutter Demo',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Landing(),
          ),
        ),
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
