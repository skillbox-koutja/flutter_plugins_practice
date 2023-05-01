import 'package:flutter/material.dart';
import 'package:flutter_video_app/domain/video/video.dart';
import 'package:flutter_video_app/ui/video/player/fullscreen_video.dart';
import 'package:flutter_video_app/ui/video/player/video_preview.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final Video video;

  const VideoPlayerWidget({
    super.key,
    required this.video,
  });

  @override
  VideoPlayerWidgetState createState() => VideoPlayerWidgetState();
}

class VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network(widget.video.sources[0])
      ..addListener(() {
        setState(() {});
      })
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VideoPreview(
      video: widget.video,
      onPlayTap: () {
        _showFullscreenVideoModal(context);
      },
    );
  }

  _showFullscreenVideoModal(context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (_, __, ___) {
        return FullscreenVideo(
          video: widget.video,
          controller: _controller,
        );
      },
    );
  }
}
