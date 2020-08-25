import 'package:flutter/material.dart';
import 'package:youtube_api/youtube_api.dart';
import '../apikey.dart';
import 'package:youtube_clone/theme/constants.dart';
import '../widgets/video_list.dart';

class Subscriptions extends StatefulWidget {
  @override
  _SubscriptionsState createState() => _SubscriptionsState();
}

class _SubscriptionsState extends State<Subscriptions> {
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
          height: 100.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildButtonColumn(Icons.person, "Dota2"),
              _buildButtonColumn(Icons.person, "LTT"),
              _buildButtonColumn(Icons.person, "PewDiePie"),
              _buildButtonColumn(Icons.person, "Bitwit"),
              _buildButtonColumn(Icons.person, "YouTube"),
            ],
          ),
        ),
        Container(
            color: Color(colorBG),
            child: _ytResults.length != 0
                ? VideoList(
                    listData: _ytResults,
                  )
                : Center(child: Container(child: CircularProgressIndicator(),)))
      ],
    );
  }

  Widget _buildButtonColumn(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: 50.0,
            height: 50.0,
            padding: const EdgeInsets.only(bottom: 8.0),
            decoration: BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, 0.7),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 30.0,
            ),
          ),
          Text(
            text,
            style: TextStyle(color: Colors.grey[700]),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
