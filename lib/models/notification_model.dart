class NotificationModel {
  final String name;
  final String messageType;
  final String message;
  final String timeStamp;
  final String avatarUrl;

  NotificationModel(
      {this.name,
      this.messageType,
      this.message,
      this.timeStamp,
      this.avatarUrl});
}

List<NotificationModel> notificationData = [
  NotificationModel(
    message: "Memology 101 uploaded: TikTok Needs To Be Stopped",
    timeStamp: "42 minutes ago",
  ),
  NotificationModel(
    message: "Linus Tech Tips uploaded: Free performance for Ryzen!",
    timeStamp: "6 hours ago",
  ),
  NotificationModel(
    message: "AdmiralBulldog uploaded: Annihilating with Alfredo",
    timeStamp: "8 hours ago",
  ),
  NotificationModel(
    message: "TLG uploaded: Why I don't want more users to switch to Linux",
    timeStamp: "12 day ago",
  ),
  NotificationModel(
    message: "Austin Evans uploaded: The ULTIMATE AMD Gaming PC Build",
    timeStamp: "1 day ago",
  ),
  NotificationModel(
    message: "Memology 102 uploaded: TikTok Needs To Be Stopped",
    timeStamp: "2 days ago",
  ),
  NotificationModel(
    message: "Memology 103 uploaded: TikTok Needs To Be Stopped",
    timeStamp: "3 days ago",
  ),
];
