import 'package:flutter/material.dart';
import '../models/notification_model.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final List<NotificationModel> data = notificationData;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: data.length, itemBuilder: (context, index) {
          return ListTile(
            dense: true,
            leading: CircleAvatar(child: Icon(Icons.person), radius: 16.0,),
            title: Text("${data[index].message}"),
            subtitle: Text(data[index].timeStamp),
            trailing: IconButton(icon: Icon(Icons.more_vert), onPressed: (){}),
          );
    });
  }
}