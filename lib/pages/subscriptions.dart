import 'package:flutter/material.dart';
import 'package:youtube_api/youtube_api.dart';
import '../apikey.dart';
import 'package:youtube_clone/theme/constants.dart';
import '../widgets/video_list.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// import 'package:http/src/response.dart';
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

    callAPI("Random Dota2 & YouTube");
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

  Future<http.Response> getVideoStats(String channel) async {
    return http.get(
        "https://www.googleapis.com/youtube/v3/channels?part=snippet&fields=items%2Fsnippet%2Fthumbnails%2Fdefault&forUsername=${channel}&key=${apikey}");
    // return json.decode(response.body)['items'][0]['statistics']['viewCount'].toString();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          color: Color(colorBG),
          height: 100.0,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
                      child: Row(
              // direction: Axis.horizontal,
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButtonColumn("Dota2"),
                // Spacer(flex: 1,),
                _buildButtonColumn("LinusTechTips"),
                // Spacer(flex: 1,),
                _buildButtonColumn("PewDiePie"),
                // Spacer(flex: 1,),
                _buildButtonColumn("Bitwit"),
                // Spacer(flex: 1,),
                _buildButtonColumn("YouTube"),
                // Spacer(flex: 1,),
                _buildButtonColumn("Flutter"),
                _buildButtonColumn("aryanjalali1234"),
                // Spacer(flex: 10,),

              ],
            ),
          ),
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
                  )))
      ],
    );
  }

  Widget _buildButtonColumn(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SizedBox(
            height: 55,
                      child: Container(
                // width: 55.0,
                // height: 55.0,
                // padding: const EdgeInsets.only(left: 12),
                // decoration: BoxDecoration(
                //   color: Color.fromRGBO(0, 0, 0, 0.7),
                //   shape: BoxShape.circle,
                // ),
                child: FutureBuilder(
                  future: getVideoStats(text),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return 
                      ClipOval(
                          child: Image.network(
                        "${json.decode(snapshot.data.body)['items'][0]['snippet']['thumbnails']['default']['url'].toString()}",
                        fit: BoxFit.fill,
                      ));
                      // CircleAvatar(
                      //   // radius: 50,
                      //   backgroundImage: NetworkImage(
                      //       "${json.decode(snapshot.data.body)['items'][0]['snippet']['thumbnails']['default']['url'].toString()}"),
                      //   // json.decode(response.body)['items'][0]['statistics']['viewCount'].toString()
                      // );
                    }
                    if (snapshot.hasError) {
                      return Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 30.0,
                      );
                    }
                    return Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 30.0,
                    );
                  },
                )
                // CircleAvatar(
                //     backgroundImage: NetworkImage(""),
                //   ),
                // Icon(
                //   Icons.person,
                //   color: Colors.white,
                //   size: 30.0,
                // ),
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
