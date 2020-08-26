import 'package:flutter/material.dart';
import 'package:youtube_clone/widgets/video_list.dart';
import '../theme/constants.dart';
import 'package:youtube_api/youtube_api.dart';
import '../widgets/mixin.dart';
import '../apikey.dart';
import 'package:http/http.dart' as http;

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

    callAPI("Random Linus");
    super.initState();
  }

  Future<Null> callAPI(String query, {bool nextPage}) async {
    if (_ytResults.isNotEmpty) {
      // videoItem.clear();
      _ytResults.clear();
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
            ? ListView(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SizedBox(width: 5,),
                        chipBuilder("MOBA"),
                        chipBuilder("Tech"),
                        chipBuilder("Computers"),
                        chipBuilder("Nvidia RTX"),
                        chipBuilder("Anime"),
                        chipBuilder("Ryzen"),
                        chipBuilder("Platform games"),
                        SizedBox(width: 5,),
                      ],
                    ),
                  ),
                  VideoList(
                    listData: _ytResults,
                  ),
                ],
              )
            : Center(child: CircularProgressIndicator()));
  }

  @override
  void onTap(YT_API apiItem, BuildContext context) {
    setState(() {
      videoId = apiItem.id;
    });
  }

  Widget chipBuilder(String label) {
    return Container(
      margin: EdgeInsets.only(left: 8.0, top: 2.0, bottom: 2.0),
      child: ActionChip(
        labelPadding: EdgeInsets.fromLTRB(6.0, 1.0, 6.0, 1.0),
        label: Text(label),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        onPressed: (){
          callAPI(label);
        },
      ),
    );
  }
}