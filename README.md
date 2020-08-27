# YouTube Clone

A YouTube clone made using Flutter.

Most of the App is only front end, although it can query for videos with the search and the home page displays videos as well. Both of these functionalities utilize youtube_api package.

# Supports:
- Supports Google sign in
- Uses youtube_player_flutter to run videos.
- Uses youtube_api to run queries and get a list of videos. 
- Has a front end for most things on YouTube.

# Not currently supporting:
- Doesn't have a comments section for videos as of now
- Downloading videos.
- Fullscreen mode for videos is a little bugged.

# Before you run:
- Please add your google-services.json file in android/app folder as mentioned in Firebase documentation.
- Don't forget to replace <API_KEY> string in apikey.dart file which you should have from Google Cloud's YouTube Data API.
