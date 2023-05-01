import 'package:flutter/material.dart';
import 'package:flutter_video_app/domain/video/video.dart';

class VideoPreview extends StatelessWidget {
  final Video video;
  final VoidCallback onPlayTap;

  const VideoPreview({
    super.key,
    required this.video,
    required this.onPlayTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
      foregroundColor: Colors.white,
            flexibleSpace: Hero(
              tag: 'video',
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  color: Colors.black,
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.network(
                        video.thumb,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                        ),
                        child: GestureDetector(
                          onTap: onPlayTap,
                          child: const Center(
                            child: Icon(
                              Icons.play_circle_fill,
                              size: 50,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            pinned: true,
            collapsedHeight: 200,
            expandedHeight: 360,
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Text(
                  video.title,
                ),
                Text(
                  video.subtitle,
                ),
                const SizedBox(height: 16),
                Text(
                  video.description,
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
