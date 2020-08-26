import 'package:flutter/material.dart';
import '../models/youtube_model.dart';
import 'package:youtube_api/youtube_api.dart';
import '../pages/video_details.dart';
import 'package:http/http.dart' as http;

class VideoList extends StatelessWidget {
  final List<YT_API> listData;
  final bool isMiniList;
  final bool isHorizontalList;

  const VideoList(
      {this.listData, this.isMiniList = false, this.isHorizontalList = false});

  @override
  Widget build(BuildContext context) {
    final deviceOrientation = MediaQuery.of(context).orientation;
    if (isHorizontalList) {
      return ListView.builder(
        padding: const EdgeInsets.all(8.0),
        scrollDirection: Axis.horizontal,
        itemCount: listData.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              debugPrint("Hereee: " + listData[index].channelId);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    VideoDetail(detail: listData[index], listData: listData),
              ));
            },
            child: _buildHorizontalList(context, index),
          );
        },
      );
    } else {
      return ListView.separated(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          if (isMiniList || deviceOrientation == Orientation.landscape) {
            return InkWell(
              onTap: () {
                debugPrint("Hereee: " + listData[index].channelId);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      VideoDetail(detail: listData[index], listData: listData),
                ));
              },
              child: _buildLandscapeList(context, index),
            );
          } else {
            return InkWell(
              onTap: () {
                debugPrint("Hereee: " + listData[index].channelId);

                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      VideoDetail(detail: listData[index], listData: listData),
                ));
              },
              child: _buildPortraitList(context, index),
            );
          }
        },
        separatorBuilder: (context, index) => Divider(
          height: 0.5,
          color: Colors.white,
        ),
        itemCount: listData.length,
      );
    }
  }

  Widget _buildPortraitList(BuildContext context, int index) {
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: 250.0,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(listData[index].thumbnail['high']['url']),
                fit: BoxFit.cover),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Align(
                  child: Text(
                    listData[index].duration,
                    style: TextStyle(
                        backgroundColor: Colors.black, color: Colors.white),
                  ),
                  alignment: Alignment.bottomRight,
                ),
              ),
            ],
          ),
        ),
        ListTile(
          contentPadding: const EdgeInsets.all(8.0),
          dense: true,
          leading: 
          // Icon(Icons.person),
          CircleAvatar(
            backgroundImage: NetworkImage(listData[index].channelPhotoURL),
          ),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              listData[index].title,
              style: TextStyle(color: Colors.white),
            ),
          ),
          subtitle: Text(
            "${listData[index].channelTitle} . ${listData[index].viewCount} views . ${listData[index].publishedAt}",
            style: TextStyle(color: Colors.grey[400]),
          ),
          trailing: Container(
              margin: const EdgeInsets.only(bottom: 20.0),
              child: Icon(
                Icons.more_vert,
                color: Colors.white,
              )),
        ),
      ],
    );
  }

  Widget _buildLandscapeList(BuildContext context, int index) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: <Widget>[
          Container(
//          width: MediaQuery.of(context).size.width / 2,
            width: isMiniList
                ? MediaQuery.of(context).size.width / 2
                : 336.0 / 1.5,
            height: isMiniList ? 100.0 : 188.0 / 1.5,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(listData[index].thumbnail['high']['url']),
                  fit: BoxFit.cover),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Align(
                    child: Text(
                      listData[index].duration,
                      style: TextStyle(
                          backgroundColor: Colors.black, color: Colors.white),
                    ),
                    alignment: Alignment.bottomRight,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  contentPadding: const EdgeInsets.all(8.0),
                  dense: isMiniList ? true : false,
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Text(
                      listData[index].title,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  subtitle: !isMiniList
                      ? Text(
                          "${listData[index].channelTitle} . ${listData[index].viewCount} views . ${listData[index].publishedAt}",
                          style: TextStyle(color: Colors.grey[400]),
                        )
                      : Text(
                          "${listData[index].channelTitle} . ${listData[index].viewCount} views",
                          style: TextStyle(color: Colors.grey[400]),
                        ),
                  trailing: Container(
                      margin: const EdgeInsets.only(bottom: 30.0),
                      child: Icon(
                        Icons.more_vert,
                        color: Colors.white,
                      )),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: !isMiniList
                      ? Container()
                      // CircleAvatar(
                      //     backgroundImage:
                      //         NetworkImage(listData[index].channelAvatar),
                      //   )
                      : SizedBox(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalList(BuildContext context, int index) {
    return Container(
      width: 336.0 / 2.2,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(bottom: 4.0),
            width: 350.0 / 2.2,
            height: 180 / 2.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(listData[index].thumbnail['high']['url']),
              ),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Align(
                    child: Text(
                      listData[index].duration,
                      style: TextStyle(
                          backgroundColor: Colors.black, color: Colors.white),
                    ),
                    alignment: Alignment.bottomRight,
                  ),
                ),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Text(
                        listData[index].title,
                        style:
                            TextStyle(fontSize: 12.0, color: Colors.grey[400]),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      listData[index].channelTitle,
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.more_vert,
                size: 16.0,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
