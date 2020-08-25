import 'package:flutter/material.dart';
import 'package:youtube_clone/theme/constants.dart';
import 'package:youtube_api/youtube_api.dart';
import '../widgets/video_list.dart';
import '../apikey.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  YoutubeAPI _youtubeAPI;
  List<YT_API> _ytResults = [];
  // List<VideoItem> videoItem = [];
  String videoId;

  @override
  void initState() {
    _youtubeAPI = YoutubeAPI(apikey, type: "video", maxResults: 10);
    _ytResults = [];
    // videoItem = [];

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
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(colorBG),
          appBar: AppBar(
            backgroundColor: Color(colorBG),
            title: TextField(
              style: TextStyle(color: Colors.white),
              autofocus: false,
              onSubmitted: (value) {
                callAPI(value);
              },
              decoration: InputDecoration(
                  fillColor: Colors.grey[400],
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide.none),
                  hintText: "Search YouTube",
                  hintStyle: TextStyle(color: Colors.grey[400])),
            ),
          ),
          body: _ytResults.length == 0
              ? ListView(
                  children: [
                    ListTile(
                      trailing: Icon(
                        Icons.call_received,
                        color: Colors.grey[400],
                      ),
                      leading: Icon(Icons.history, color: Colors.grey[400]),
                      title: Text(
                        "LTT",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ListTile(
                      trailing: Icon(
                        Icons.call_received,
                        color: Colors.grey[400],
                      ),
                      leading: Icon(Icons.history, color: Colors.grey[400]),
                      title: Text(
                        "House",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ListTile(
                      trailing: Icon(
                        Icons.call_received,
                        color: Colors.grey[400],
                      ),
                      leading: Icon(Icons.history, color: Colors.grey[400]),
                      title: Text(
                        "Dota",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                )
              : Container(
                  color: Color(colorBG),
                  child: _ytResults.length != 0
                      ? VideoList(
                          listData: _ytResults,
                        )
                      : Center(child: CircularProgressIndicator()))),
    );
  }
}
