import 'package:flutter/material.dart';
import '../stores/drawer_store.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../stores/module_view_store.dart';
import '../stores/module_page_store.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer(this.itemList, this.icon);
  final List itemList;
  final String icon;

  @override
  Widget build(BuildContext context) {
    var itemStore = Provider.of<DrawerStore>(context);
    var _barStore = Provider.of<ViewStore>(context);
    var pageStore = Provider.of<PageStore>(context);

    Widget articles(item, context) {
      return Observer(
        builder: (_) => ListTile(
          title: Text(
            "${item["name"]}",
          ),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            //todo
            itemStore.setCurrent(item["name"]);
            _barStore.setCurrentName(itemStore.getCurrent);
            print(item);
            pageStore.setPage(item["content"]);
          },
          selected: itemStore.current == item["name"] ? true : false,
        ),
      );
    }

    return Drawer(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 30,
            child: DrawerHeader(
              child: Container(
                height: double.maxFinite,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: new NetworkImage(this.icon),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 70,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: itemList.length,
              //itemExtent: 100.0,
              itemBuilder: (context, index) {
                var item = itemList[index];
                return ExpansionTile(
                  title: Text("loool"),
                  children: item["articles"]
                      .map<Widget>((item) => articles(item, context))
                      .toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
