import 'package:flutter/material.dart';
import 'package:youtube_api/youtube_api.dart';
import '../apikey.dart';
import 'package:youtube_clone/theme/constants.dart';
import '../widgets/video_list.dart';

class Explore extends StatefulWidget {
  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
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
    return ListView(
      children: [
        Container(
          color: Color(colorBG),
          height: 227.0,
          child: Wrap(
            runAlignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            direction: Axis.horizontal,
            children: [
              _buildButtonColumn(Icons.trending_up, "Trending", Colors.red),
              _buildButtonColumn(Icons.music_note, "Music", Colors.teal[300]),
              _buildButtonColumn(Icons.games, "Gaming", Colors.deepOrange[100]),
              _buildButtonColumn(Icons.new_releases, "News", Colors.blue),
              _buildButtonColumn(Icons.local_movies, "Movies", Colors.yellow),
              _buildButtonColumn(
                  Icons.calendar_today, "Fashion & Beauty", Colors.purple[100]),
              _buildButtonColumn(
                  Icons.filter_tilt_shift, "Learning", Colors.green[300]),
              _buildButtonColumn(Icons.live_tv, "Live", Colors.orange),
            ],
          ),
        ),
        Divider(
          color: Colors.white,
        ),
        _buildRecent(),
        Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 16, bottom: 16),
          child: Text("Trending videos"),
        ),
        Container(
            color: Color(colorBG),
            child: _ytResults.length != 0
                ? VideoList(
                    listData: _ytResults,
                  )
                : Center(
                    child: Container(
                    child: CircularProgressIndicator(),
                  ))),
      ],
    );
  }

  BoxDecoration _buildBottomBorder() => BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: Colors.grey[400]),
        ),
      );

  Widget _buildRecent() {
    return Container(
      height: 200.0,
      decoration: _buildBottomBorder(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 16.0, left: 16.0),
          ),
          Expanded(
            child: VideoList(
              listData: _ytResults,
              isHorizontalList: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonColumn(IconData icon, String text, Color colorTile) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: 200.0,
            height: 45.0,
            // padding: const EdgeInsets.only(bottom: 8.0),
            decoration: BoxDecoration(
              color: colorTile,
              shape: BoxShape.rectangle,
            ),
            child: Center(
              child: ListTile(
                dense: true,
                title: Text(
                  text,
                  style: TextStyle(color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
                leading: Icon(icon, color: Colors.white, size: 30.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
