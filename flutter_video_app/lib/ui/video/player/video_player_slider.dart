import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerSlider extends StatelessWidget {
  final VideoPlayerController controller;

  const VideoPlayerSlider({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (_, videoState, __) {
        if (!videoState.isInitialized) {
          return const SizedBox.shrink();
        }

        final int duration = videoState.duration.inMilliseconds;
        final int position = videoState.position.inMilliseconds;

        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 32,
              child: Slider.adaptive(
                value: position / duration,
                activeColor: Colors.cyanAccent,
                onChanged: _onChanged,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formatDuration(videoState.position),
                    style: const TextStyle(color: Colors.white),
                  ),
                  Text(
                    formatDuration(videoState.duration),
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _onChanged(double value) {
    controller.pause();
    controller.seekTo(controller.value.duration * value);
  }

  static String formatDuration(Duration d) {
    final minutes = (d.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (d.inSeconds % 60).toString().padLeft(2, '0');

    return '${d.inHours}:$minutes:$seconds';
  }
}
