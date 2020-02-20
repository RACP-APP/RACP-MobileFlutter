import 'package:RACR/stores/drawer_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import '../stores/module_view_store.dart';
import '../stores/drawer_store.dart';
import './modules_drawer.dart';
import './module_page.dart';
import '../stores/module_page_store.dart';
import '../widgets/test2.dart';

List foo() {
  List<Map> data = List();
  data.add({"name": "me", "content": "hmm"});
  data.add({"name": "You", "content": "github"});
  data.add({"name": "We", "content": "calcium"});
  data.add({"name": "who", "content": "google"});
  return data;
}

var x = foo();

class ModulesView extends StatelessWidget {
  ModulesView(this.dataList);
  List dataList = [];

  @override
  Widget build(BuildContext context) {
    var storeP = Provider.of<PageStore>(context);
    return SafeArea(
      child: Scaffold(
        drawer: MyDrawer(dataList),
        appBar: MyCustomAppBar(
          height: 58,
        ),
        body: Center(
          child: Observer(
            builder: (_) => Testing(contentList: storeP.pageNum),
          ),
          /*FlutterLogo(
              size: MediaQuery.of(context).size.width,
            ),*/
        ),
      ),
    );
  }
}

class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const MyCustomAppBar({
    Key key,
    @required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final barStore = Provider.of<ViewStore>(context);
    return Column(
      children: [
        Container(
          child: Container(
            color: Colors.grey,
            padding: EdgeInsets.all(5),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                  Observer(
                    builder: (_) => Text(
                      "${barStore.getName}",
                    ),
                  ),
                  Text("home"),
                  Text("notification"),
                ]),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
