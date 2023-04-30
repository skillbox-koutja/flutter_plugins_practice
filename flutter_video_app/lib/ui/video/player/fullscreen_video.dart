import 'package:flutter/material.dart';
import 'package:flutter_video_app/domain/video/video.dart';
import 'package:flutter_video_app/ui/video/player/video_player_controls.dart';
import 'package:video_player/video_player.dart';

class FullscreenVideo extends StatelessWidget {
  final Video video;
  final VideoPlayerController controller;

  const FullscreenVideo({
    super.key,
    required this.video,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Hero(
          tag: 'video',
          child: Center(
            child: AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: Stack(
                children: [
                  VideoPlayer(controller),
                  VideoPlayerControls(controller: controller),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}