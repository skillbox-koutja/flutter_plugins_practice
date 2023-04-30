import 'package:flutter_video_app/domain/video/video.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_video_app/ui/video/catalog/page.dart';
import 'package:flutter_video_app/ui/video/player/page.dart';

var rootHandler = Handler(handlerFunc: (_, __) {
  return const VideoCatalogPage();
});

var videoCatalogHandler = Handler(handlerFunc: (_, __) {
  return const VideoCatalogPage();
});

var videoPlayerHandler = Handler(handlerFunc: (_, params) {
  var videoId = params['id'] ?? [Video.unknown().id];

  return VideoPlayerPage(videoId: videoId.first);
});
