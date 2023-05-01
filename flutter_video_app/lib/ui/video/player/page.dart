import 'package:flutter_video_app/config/application.dart';
import 'package:flutter_video_app/domain/video/video.dart';
import 'package:flutter_video_app/ui/status_view/status_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_video_app/ui/video/player/video_player_widget.dart';

class VideoPlayerPage extends StatefulWidget {
  static const String routeName = '/video/:id';
  static String prepareRouteParams(String id) => '/video/$id';

  final String videoId;

  const VideoPlayerPage({
    super.key,
    required this.videoId,
  });

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  bool loaded = false;
  late Video video;

  @override
  void initState() {
    super.initState();

    Application.videosFetcher.fetch().then(
          (data) => setState(() {
            loaded = true;
            video = data.firstWhere(
              (element) => element.id == widget.videoId,
              orElse: () {
                return Video.unknown();
              },
            );
          }),
        );
  }

  @override
  Widget build(BuildContext context) {
    if (loaded) {
      return VideoPlayerWidget(video: video);
    }

    return const Scaffold(body: LoadingStatusView());
  }
}
