import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:parent_app/models/playlist.dart';
import 'package:parent_app/models/video.dart';

class APIService {
  APIService._instantiate();

  static final APIService instance = APIService._instantiate();

  final String _baseUrl = 'www.googleapis.com';
  String _nextPageToken = '';

  Future<Playlist> fetchPlaylist({String playlistId}) async {
    Map<String, String> parameters = {
      'part': 'snippet, contentDetails, localizations',
      'id': playlistId,
      'key': 'AIzaSyCCujdADpW5_7jmJVX4kqSWR3-4TFqN0Mg',
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/playlists',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    // Get Channel
    var response = await http.get(uri, headers: headers);
//    print(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      Playlist playlist = Playlist.fromMap(data['items'][0]);

      // Fetch first batch of videos from uploads playlist
      playlist.videos = await fetchVideosFromPlaylist(
        playlistId: playlistId,
      );
      return playlist;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }

  Future<List<Video>> fetchVideosFromPlaylist({String playlistId}) async {
    Map<String, String> parameters = {
      'part': 'snippet, contentDetails',
      'playlistId': playlistId,
      'maxResults': '8',
      'pageToken': _nextPageToken,
      'key': 'AIzaSyCCujdADpW5_7jmJVX4kqSWR3-4TFqN0Mg',
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/playlistItems',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    // Get Playlist Videos
    var response = await http.get(uri, headers: headers);
//    print(response.body);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      _nextPageToken = data['nextPageToken'] ?? '';
      List<dynamic> videosJson = data['items'];

      // Fetch first eight videos from uploads playlist
      List<Video> videos = [];
      videosJson.forEach(
            (json) => videos.add(
          Video.fromMap(json['snippet']),
        ),
      );
      return videos;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }
}