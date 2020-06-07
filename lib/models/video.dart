class Video {
  final String id;
  final String title;
  final String thumbnailUrl;
  String channelTitle;
  int channelIndex;

  Video({
    this.id,
    this.title,
    this.thumbnailUrl,
    this.channelTitle,
    this.channelIndex
  });

  setChannelTitle(String title)
  {
    this.channelTitle = title;
  }

  setIndex(int playlistIndex)
  {
    this.channelIndex=playlistIndex;
  }

  factory Video.fromMap(Map<String, dynamic> snippet) {
    return Video(
      id: snippet['resourceId']['videoId'],
      title: snippet['title'],
      thumbnailUrl: snippet['thumbnails']['high']['url'],
      channelTitle: snippet['channelTitle'],
    );
  }
}