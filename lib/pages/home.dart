import 'package:flutter/material.dart';
import 'package:youtube_clone/widgets/video_list.dart';
import '../theme/constants.dart';
import 'package:youtube_api/youtube_api.dart';
import '../widgets/mixin.dart';
import '../apikey.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>
    with ListPopupTap<Home>, PortraitMode<Home> {
  TextEditingController textController;
  YoutubeAPI _youtubeAPI;
  List<YT_API> _ytResults = [];
  // List<VideoItem> videoItem = [];
  String videoId;

  @override
  void initState() {
    _youtubeAPI = YoutubeAPI(apikey, type: "video", maxResults: 10);
    _ytResults = [];
    // videoItem = [];

    callAPI("Linus");
    super.initState();
  }

  Future<Null> callAPI(String query, {bool nextPage}) async {
    if (_ytResults.isNotEmpty) {
      // videoItem.clear();
    }

    if (nextPage == null) {
      _ytResults = await _youtubeAPI.search(query);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(colorBG),
        child: _ytResults.length != 0
            ? VideoList(
                listData: _ytResults,
              )
            : Center(child: CircularProgressIndicator()));
  }

  @override
  void onTap(YT_API apiItem, BuildContext context) {
    setState(() {
      videoId = apiItem.id;
    });

    // Navigator.of(context).push(PopupVideoPlayerRoute(
    //   child: PopupVideoPlayer(
    //     videoId: videoId,
    //   ),
    // ));
  }
}

// class VideoItem extends StatelessWidget {
//   final YT_API api;
//   final ListPopupTap listPopupTap;

//   const VideoItem({Key key, this.api, this.listPopupTap}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Card(
//         child: ListTile(
//           leading: Image.network(api.thumbnail["high"]["url"]),
//           title: Text(api.title),
//           subtitle: Text(api.channelTitle),
//           onTap: () {
//             listPopupTap.onTap(api, context);
//           },
//         ),
//       ),
//     );
//   }
// }
