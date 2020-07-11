import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class KnowledgeDbPlayer extends StatefulWidget {
  final String url;
  const KnowledgeDbPlayer({Key key, this.url}) : super(key: key);

  @override
  _KnowledgeDbPlayerState createState() => _KnowledgeDbPlayerState();
}

class _KnowledgeDbPlayerState extends State<KnowledgeDbPlayer> {
  YoutubePlayerController _controller;
  PlayerState _playerState;
  YoutubeMetaData _videoMetaData;
  bool _isPlayerReady = false;
  bool loading = true;
  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: widget.url,
      flags: YoutubePlayerFlags(
        autoPlay: true,
      ),
    )..addListener(listener);
    super.initState();
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
        loading = false;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: loading ?
          YoutubePlayer(
            controller: _controller,
//            onReady: () => _controller.play(),
//            showVideoProgressIndicator: true,
          ):Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).primaryColor, // Red
              ),
            ),
          )
        ),
      ),
    );
  }
}
