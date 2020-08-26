import 'package:flutter/material.dart';
import '../widgets/video_list.dart';
import 'package:youtube_api/youtube_api.dart';
import '../apikey.dart';

class Library extends StatefulWidget {
  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  YoutubeAPI _youtubeAPI;
  List<YT_API> _ytResults = [];
  // List<VideoItem> videoItem = [];
  String videoId;

  @override
  void initState() {
    _youtubeAPI = YoutubeAPI(apikey, type: "video", maxResults: 10);
    _ytResults = [];
    // videoItem = [];

    callAPI("Random Japan");
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
        _buildRecent(),
        _buildPersonal(context),
        _buildPlaylist(context),
      ],
    );
  }

  BoxDecoration _buildBottomBorder() => BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: Colors.grey),
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
            child: Text("Recent"),
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

  Widget _buildPersonal(BuildContext context) {
    List<Map> items = [
      {"name": "History", "icon": Icon(Icons.history)},
      {
        "name": "Downloads",
        "icon": Icon(Icons.file_download),
        "extra": "20 recommendations"
      },
      {"name": "Your Videos", "icon": Icon(Icons.video_library)},
      {"name": "Purchases", "icon": Icon(Icons.loyalty)},
      {
        "name": "Watch Later",
        "icon": Icon(Icons.watch_later),
        "extra": "1502 unwatched videos"
      },
    ];

    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: _buildBottomBorder(),
      child: Column(
        children: items
            .map((i) => ListTile(
                  leading: i["icon"],
                  title: i["extra"] == null
                      ? Text(i["name"])
                      : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(i["name"]),
                            Container(
                              margin: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                i["extra"],
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ),
                          ],
                        ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildPlaylist(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8.0, left: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Playlists"),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton(
                  style: Theme.of(context).textTheme.bodyText1,
                  items: [
                    DropdownMenuItem(child: Text("(Recently added)")),
                    DropdownMenuItem(child: Text("(A - Z)")),
                  ],
                  onChanged: (value){},
                ),
              ),
            ],
          ),
          ListTile(
            leading: Icon(Icons.add,color: Colors.blue,),
            title: Text("New playlist", style: TextStyle(color: Colors.blue),),
          ),
          ListTile(
            leading: Icon(Icons.thumb_up),
            title: Text("Liked videos"),
            subtitle: Text("248 videos"),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text("Adobe Photoshop Tutorials"),
            subtitle: Text("Dansky . 150 videos"),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text("Favorites"),
            subtitle: Text("351 videos"),
          ),
        ],
      ),
    );
  }
}
