import 'package:flutter/material.dart';
import 'package:youtube_api/youtube_api.dart';
import 'package:youtube_clone/theme/constants.dart';
import '../widgets/video_list.dart';

class VideoDetail extends StatefulWidget {
  final YT_API detail;
  final List<YT_API> listData;

  const VideoDetail({Key key, @required this.detail, @required this.listData}) : super(key: key);

  @override
  _VideoDetailState createState() => _VideoDetailState();
}

class _VideoDetailState extends State<VideoDetail> {
  @override
  Widget build(BuildContext context) {
    List<Widget> _layouts = [
      _videoInfo(),
      _channelInfo(),
      _moreInfo(),
      VideoList(
        listData: widget.listData,
        isMiniList: false,
      ),
    ];

    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      _layouts.clear();
    }

    return SafeArea(
          child: Scaffold(
            backgroundColor: Color(colorBG),
          body: Column(
        children: <Widget>[
          _buildVideoPlayer(context),
          Expanded(
            child: ListView(
              children: _layouts,
            ),
          )
        ],
      )),
    );
  }

  Widget _buildVideoPlayer(BuildContext context) {
    return Container(
      // margin: new EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).orientation == Orientation.portrait
          ? 250.0
          : MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(widget.detail.thumbnail['high']['url']), fit: BoxFit.cover)),
    );
  }

  Widget _videoInfo() {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(widget.detail.title, style: TextStyle(color: Colors.white),),
          subtitle: Text("1M views", style: TextStyle(color: Colors.grey[400]),),
          trailing: Icon(Icons.arrow_drop_down, color: Colors.grey[400]),
        ),
        Container(
          padding: const EdgeInsets.only(left:35.0,right: 35.0,bottom: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _buildButtonColumn(Icons.thumb_up, "15K"),
              _buildButtonColumn(Icons.thumb_down, "100"),
              _buildButtonColumn(Icons.share, "Share"),
              _buildButtonColumn(Icons.file_download, "Download"),
              _buildButtonColumn(Icons.add_to_photos, "Save"),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildButtonColumn(IconData icon, String text) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Icon(
            icon,
            color: Colors.grey[400],
          ),
        ),
        Text(
          text,
          style: TextStyle(color: Colors.grey[400]),
        ),
      ],
    );
  }

  Widget _channelInfo() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey, width: 0.5),
          bottom: BorderSide(color: Colors.grey, width: 0.5),
        ),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: ListTile(
              leading: Icon(Icons.person,color: Colors.white,),
              // CircleAvatar(
              //   backgroundImage: NetworkImage(widget.detail.channelAvatar),
              // ),
              title: Text(
                widget.detail.channelTitle,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text("15,000 subscribers", style: TextStyle(color: Colors.grey[400]),),
            ),
          ),
          FlatButton(
              onPressed: () {},
              // icon: Icon(
              //   Icons.play_circle_filled,
              //   color: Colors.red,
              // ),
              child: Text(
                "SUBSCRIBE",
                style: TextStyle(color: Colors.red),
              ))
        ],
      ),
    );
  }

  Widget _moreInfo() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(child: Text("Up next", style: TextStyle(color: Colors.grey[400]),)),
          Text("Autoplay", style: TextStyle(color: Colors.grey[400]),),
          Switch(
            onChanged: (c) {},
            value: true,
          ),
        ],
      ),
    );
  }
}
