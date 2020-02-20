import 'package:flutter/material.dart';
import 'utils/route_generator.dart';
import 'ui/module_list.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import './widgets/file_downloader.dart';
import './widgets/file_downloader_single.dart';
import './widgets/test_widget.dart';
//import 'widgets/video_handler.dart';
import './widgets/test2.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import './stores/module_view_store.dart';
import './stores/drawer_store.dart';
import './ui/modules_drawer.dart';
import './ui/module_page.dart';
import './stores/module_page_store.dart';

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
        home: ModulesList(),
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
