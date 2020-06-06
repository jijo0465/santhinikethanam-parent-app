import 'package:parent_app/models/video.dart';

class Playlist {
  final String id;
  String title;
  final String videoCount;
  List<Video> videos;

  Playlist({
    this.id,
    this.title,
    this.videoCount,
    this.videos,
  });


  factory Playlist.fromMap(Map<String, dynamic> map) {
    return Playlist(
      id: map['id'],
      title: map['snippet']['title'],
      videoCount: map['contentDetails']['itemCount'].toString(),
    );
  }
}