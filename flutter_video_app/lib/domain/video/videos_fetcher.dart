import 'package:flutter_video_app/domain/video/video.dart';
import 'package:flutter_video_app/fetch_file.dart';

class VideosFetcher {
  Future<List<Video>> fetch() async {
    final response = await fetchJsonFromAssetsFile('assets/videos.json');
    List<dynamic> videos = response['videos'].map((video) {
      return Video.fromJson(video as Map<String, Object?>);
    }).toList();

    return videos.cast<Video>();
  }
}
