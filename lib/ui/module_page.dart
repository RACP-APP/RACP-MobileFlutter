import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../stores/module_page_store.dart';
import '../widgets/video_p.dart';
import 'package:video_player/video_player.dart';
/*
class ModulePage extends StatelessWidget {
  ModulePage();

  @override
  Widget build(BuildContext context) {
    var storePage = Provider.of<PageStore>(context);
    //var listItems = storePage.pageNum;
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        //itemCount: listItems.length,
        itemExtent: 100.0,
        itemBuilder: (context, index) {
          //var item = listItems[index];
          return Observer(builder: (_) => Text("${storePage.getPage}"));
        },
      ),
    );
  }
}
*/

class ModulePage extends StatelessWidget {
  ModulePage();

  @override
  Widget build(BuildContext context) {
    //var listItems = storePage.pageNum;
    return Container(
      child: ChewieListItem(
        videoPlayerController: VideoPlayerController.network(
          'http://techslides.com/demos/sample-videos/small.mp4',
        ),
      ),
    );
  }
}
