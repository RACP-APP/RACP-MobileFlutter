import 'package:flutter/material.dart';
import '../stores/drawer_store.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../stores/module_view_store.dart';
import '../stores/module_page_store.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer(this.itemList, this.img);
  final List itemList;
  final String img;
  final myDarkGrey = Color(0xff605E5E);
  final myDarkBlue = Color(0xff085576);
  final mylightBlue = Color(0xff8AD0EE);
  @override
  Widget build(BuildContext context) {
    var itemStore = Provider.of<DrawerStore>(context);
    var _barStore = Provider.of<ViewStore>(context);
    var pageStore = Provider.of<PageStore>(context);

    Widget articles(item, context, content) {
      return Observer(
        builder: (_) => ListTile(
          contentPadding: EdgeInsets.fromLTRB(30.0, 5.0, 5.0, 10.0),
          leading: Icon(
            Icons.done,
            color: mylightBlue,
            size: 20,
          ),
          title: Text("${item["Title"]}",
              style: GoogleFonts.lateef(
                  textStyle: TextStyle(
                      fontSize: 18.0, color: Colors.white, height: 1.1))),
          trailing: Icon(Icons.keyboard_arrow_right, color: mylightBlue),
          onTap: () {
            //todo
            itemStore.setCurrent(item["Title"]);
            _barStore.setCurrentName(itemStore.getCurrent);
            pageStore.setPage(content);
          },
          selected: itemStore.current == item["Title"] ? true : false,
        ),
      );
    }

    return Drawer(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 20,
            child: DrawerHeader(
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.all(0),
              child: Container(
                height: 100,
                margin: EdgeInsets.all(0),
                padding: EdgeInsets.all(0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: new NetworkImage(this.img),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 85,
            child: Container(
              color: myDarkBlue,
              child: ListView.builder(
                padding: EdgeInsets.all(0),
                scrollDirection: Axis.vertical,
                itemCount: itemList.length,
                //itemExtent: 100.0,
                itemBuilder: (context, index) {
                  var item = itemList[index];
                  return Container(
                      margin: EdgeInsets.all(0),
                      decoration: BoxDecoration(color: myDarkBlue),
                      child: ExpansionTile(
                        leading:
                            Icon(Icons.done_all, color: mylightBlue, size: 20),
                        title: Container(
                            padding: EdgeInsets.only(left: 0),
                            decoration: BoxDecoration(color: myDarkBlue),
                            child: Text(
                              item["Title"],
                              style: GoogleFonts.lateef(
                                  textStyle: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.white,
                                      height: 1.1)),
                            )),
                        children: item["Article"]
                            .map<Widget>((item) =>
                                articles(item, context, item["content"]))
                            .toList(),
                      ));
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
