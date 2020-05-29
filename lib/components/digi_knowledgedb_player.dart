import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
//import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class KnowledgeDbPlayer extends StatefulWidget {
  final String url;
  const KnowledgeDbPlayer({Key key, this.url}) : super(key: key);

  @override
  _KnowledgeDbPlayerState createState() => _KnowledgeDbPlayerState();
}

class _KnowledgeDbPlayerState extends State<KnowledgeDbPlayer> {
//  YoutubePlayerController _controller;
  @override
  void initState() {
//    _controller = YoutubePlayerController(
//      initialVideoId: YoutubePlayer.convertUrlToId(widget.url),
      
//    );
    
    super.initState();
  }

//  @override
//  void dispose() {
////    _controller.dispose();
//    super.dispose();
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: 
          VideoPlayer(
            VideoPlayerController.asset('assets/videos/smartschool.mp4'),
          ),
        ),
      ),
    );
  }
}
