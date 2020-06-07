//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter/material.dart';
//import 'package:video_player/video_player.dart';
//import 'package:parent_app/components/digicampus_appbar.dart';
//import 'package:parent_app/models/playlist.dart';
//import 'package:parent_app/models/video.dart';
//
////import 'package:youtube_player_flutter/youtube_player_flutter.dart';
//// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
//
//class ValueEducationScreen extends StatefulWidget {
//  const ValueEducationScreen({Key key}) : super(key: key);
//
//  @override
//  _ValueEducationScreenState createState() => _ValueEducationScreenState();
//}
//
//class _ValueEducationScreenState extends State<ValueEducationScreen> {
//
//  Playlist _playlist;
//   VideoPlayerController _playerController;
////  YoutubePlayerController _playerController;
//  List<String> title = [
//    'Care and Compassion',
//    'Honesty',
//    'Understanding',
//    'Tolerance',
//    'Inclusion',
//    'Peace and Harmony',
//    'Integrity, Respect and Responsibility',
//    'Hardwork and Success'
//  ];
//  String videoTitle;
//  // bool isVideoPlaying;
//  List<double> _height = [75.0, 50.0, 50.0, 50.0, 50.0, 50.0, 50.0, 50.0];
//  int videoIndex;
//  Firestore firestore = Firestore.instance;
//  DocumentSnapshot valuePlaylist;
//  String _playlistId;
//  @override
//  void initState() {
//    videoTitle = title.first;
//    getValuePlaylist();
////    _playerController = YoutubePlayerController(initialVideoId: YoutubePlayer.convertUrlToId(
////            'https://www.youtube.com/watch?v=J-2ODoJUnXw')
////        );
//     _playerController = VideoPlayerController.asset(
//         'assets/videos/smartschool.mp4')
//       ..initialize().then((_) {
//         print('ViDEO');
//         // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
//         setState(() {
//           _playerController.play();
//         });
//       });
//    for (videoIndex = 0; videoIndex < title.length; videoIndex++)
//      _height[videoIndex] = 50.0;
//    _height[0] = 60.0;
//    super.initState();
//  }
//
//  @override
//  void dispose() {
////    _playerController.dispose();
//    super.dispose();
//  }
//
//  getValuePlaylist(){
//    firestore
//        .collection("value_education").document("playlist").get().then((DocumentSnapshot value) {
////          print(value['chapters']);
//      valuePlaylist = value;
////          setState((){
//      _playlistId = valuePlaylist['playlistId'];
////          });
//      _initPlaylist(_playlistId,playlistFlag-1);
//    });
//  }
//
//  _initPlaylist(String playlistId,String playlistName,int playlistIndex) async {
//    Playlist playlist = await APIService.instance
//        .fetchPlaylist(playlistId: playlistId);
////    playlist.videos.forEach((element) {
////      element.setChannelTitle(playlistName);
////      element.setIndex(playlistIndex);
////    });
//    setState(() {
//      _playlist = playlist;
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        body: Column(children: <Widget>[
//      DigiCampusAppbar(
//        icon: Icons.close,
//        onDrawerTapped: () {
//          Navigator.of(context).pop();
//        },
//      ),
//      Container(
//        height: 250,
//        width: double.infinity,
//        child: Stack(
//          children: <Widget>[
//            Center(
//                child: AspectRatio(
//                  aspectRatio: _playerController.value.aspectRatio,
//                  child: VideoPlayer(
//              _playerController,
//            ),
//                ))
//            // Center(
//            //   child: FloatingActionButton(
//            //     onPressed: () {
//            //       setState(() {
//            //         _playerController.value.isPlaying
//            //             ? _playerController.pause()
//            //             : _playerController.play();
//            //       });
//            //     },
//            //     child: Icon(
//            //       _playerController.value.isPlaying
//            //           ? Icons.pause
//            //           : Icons.play_arrow,
//            //     ),
//            //   ),
//            // )
//          ],
//        ),
//      ),
//      Expanded(
//        child: SingleChildScrollView(
//          child: Column(
//              //  mainAxisAlignment: MainAxisAlignment.center,
//              // crossAxisAlignment: CrossAxisAlignment.center,
//              children: List.generate(title.length - 1, (index) {
//            return GestureDetector(
//              onTap: () {
//                setState(() {
//                  for (videoIndex = 0; videoIndex < title.length; videoIndex++)
//                    _height[videoIndex] = 50;
//                  _height[index] = 75;
//                });
//                _playerController.seekTo(Duration(minutes: 0));
//                // _youtubePlayerController.seekTo(Duration(minutes: 0));
//              },
//              child: AnimatedContainer(
//                  duration: Duration(milliseconds: 400),
//                  height: _height[index],
//                  width: MediaQuery.of(context).size.width,
//                  decoration: BoxDecoration(
//                    gradient: LinearGradient(
//                        begin: Alignment.topCenter,
//                        end: Alignment.bottomCenter,
//                        colors: _height[index] == 75
//                            ? [
//                                Theme.of(context).primaryColor.withOpacity(0.2),
//                                Theme.of(context).primaryColor.withOpacity(0.9),
//                                Theme.of(context).primaryColor.withOpacity(0.9),
//                                Theme.of(context).primaryColor.withOpacity(0.2),
//                              ]
//                            : [
//                                Theme.of(context).primaryColor.withOpacity(0.8),
//                                Theme.of(context).primaryColor.withOpacity(0.5),
//                              ]),
//                    // borderRadius: BorderRadius.circular(12)
//                  ),
//                  child: Align(
//                      alignment: Alignment.center,
//                      child: Text(
//                        title.elementAt(index),
//                        // style: TextStyle(),
//                      ))),
//            );
//          })),
//        ),
//      ),
//    ]));
//  }
//}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:parent_app/components/digicampus_appbar.dart';
import 'package:parent_app/models/playlist.dart';
import 'package:parent_app/models/video.dart';
import 'package:parent_app/services/knowledge_youtube_service.dart';

class ValueEducationScreen extends StatefulWidget {
  @override
  _ValueEducationScreenState createState() => _ValueEducationScreenState();
}

class _ValueEducationScreenState extends State<ValueEducationScreen> {
  List<Map<String, dynamic>> _allPlaylist = [{}];
  Playlist _playlist;
  bool _isLoading = false;
  bool val = false;
  int grade = 8;
  String _playlistId;
  Firestore firestore = Firestore.instance;
  DocumentSnapshot valuePlaylist;

  @override
  void initState() {
    super.initState();
    _getPlaylistData();
  }

  _getPlaylistData() {
    firestore
        .collection("value_education").document("playlist").get().then((DocumentSnapshot value) {
      valuePlaylist = value;
//          setState((){
      _playlistId = valuePlaylist['playlistId'];
//          });
      print('PLAYLIST : $_playlistId');
      _initPlaylist(_playlistId);
    });
  }

  _initPlaylist(String playlistId) async {
    Playlist playlist = await APIService.instance
        .fetchPlaylist(playlistId: playlistId);
    setState(() {
      _playlist = playlist;
    });
  }

  _buildVideo(Video video) {
    return Container(
//        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      padding: EdgeInsets.all(10.0),
      height: 140.0,
      decoration: BoxDecoration(
        color: Colors.white70,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 1),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              print(video.id);
              FlutterYoutube.playYoutubeVideoById(
                  appBarColor: Colors.white,
                  backgroundColor: Colors.white,
                  apiKey: "AIzaSyCCujdADpW5_7jmJVX4kqSWR3-4TFqN0Mg",
                  videoId: video.id,
                  autoPlay: true,
                  fullScreen: true
              );
            },
            child: Container(
              width: 150.0,
              child: Stack(
                children: <Widget>[
                  Image(
                    width: 150.0,
                    image: NetworkImage(video.thumbnailUrl),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Icon(Icons.play_arrow,color: Theme.of(context).primaryColor.withOpacity(0.7),size: 80),
                  )
                ],
              ),
            ),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              children: <Widget>[
//                Flexible(
//                  flex: 1,
//                  child: Text(
//                      video.channelTitle,
//                      style: TextStyle(fontWeight: FontWeight.w700)),
//                ),
                Flexible(
                  flex: 3,
                  child: Text(
                    video.title,
                    textAlign: TextAlign.start,
                    style: TextStyle(

                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }

  _loadMoreVideos(String playlistId) async {
    _isLoading = true;
    List<Video> moreVideos = await APIService.instance
        .fetchVideosFromPlaylist(playlistId: playlistId);
    List<Video> allVideos = _playlist.videos..addAll(moreVideos);
    setState(() {
      _playlist.videos = allVideos;
    });
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          DigiCampusAppbar(
            title: 'Value Education',
            icon: Icons.close,
            onDrawerTapped: () => Navigator.of(context).pop(),
          ),
          SizedBox(height: 12),
//          ClipPath(
//              clipper: BackgroundClipper(),
//              child: Container(
//                  color: Theme.of(context).primaryColor,
//                  height: 120 - MediaQuery.of(context).padding.top,
//                  width: double.infinity,
//                  child: Column(
//                      children: <Widget>[
//                        Expanded(
//                            child: Row(
//                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                children: <Widget>[
//                                  Container(
//                                      width: MediaQuery.of(context).size.width * 0.8,
//                                      height: 35,
//                                      decoration: BoxDecoration(
//                                          color: Colors.white,
//                                          borderRadius: BorderRadius.circular(30)),
//                                      child: TextFormField(
//                                          decoration: InputDecoration(
//                                              hintText: "search",
//                                              border: OutlineInputBorder(
//                                                  borderRadius: BorderRadius.circular(30.0),
//                                                  borderSide: const BorderSide(color: Colors.blue))))),
//                                  IconButton(
//                                      icon: Icon(
//                                        Icons.search,
//                                        color: Colors.black,
//                                      ),
//                                      onPressed: () {
////                          setState(() {
////                            val = !val;
////                          });
//                                      }),
//                                ])),
//                        SizedBox(height: 40)
//                      ])
//              )),
          Expanded(
              child: Container(
                child: _playlist != null
                    ? NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollDetails) {
                    if (!_isLoading &&
                        _playlist.videos.length != int.parse(_playlist.videoCount) &&
                        scrollDetails.metrics.pixels ==
                            scrollDetails.metrics.maxScrollExtent) {
                      _loadMoreVideos(_playlistId);
                    }
                    return false;
                  },
                  child: ListView.builder(
//                        controller: ,
                    padding: EdgeInsets.all(0),
                    itemCount: _playlist.videos.length,
                    itemBuilder: (BuildContext context, int index) {
//                  if (index == 0) {
//                    return SizedBox(height: 0);
//                  }
                      Video video = _playlist.videos[index];
                      return _buildVideo(video);
                    },
                  ),
                )
                    :Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor, // Red
                    ),
                  ),
                ),
              )
          ),
        ],
      ),
    );
  }
}

class BackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var roundnessFactor = 40.0;
    var path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height);
    path.quadraticBezierTo(0, size.height - roundnessFactor, roundnessFactor,
        size.height - roundnessFactor);
    path.lineTo(size.width - roundnessFactor, size.height - roundnessFactor);
    path.quadraticBezierTo(
        size.width, size.height - roundnessFactor, size.width, size.height);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
