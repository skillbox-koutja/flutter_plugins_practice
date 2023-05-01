import 'package:flutter_video_app/config/application.dart';
import 'package:flutter_video_app/domain/video/video.dart';
import 'package:flutter_video_app/ui/status_view/status_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_video_app/ui/video/player/page.dart';

class VideoCatalogPage extends StatefulWidget {
  static const String routeName = '/video_catalog';

  const VideoCatalogPage({Key? key}) : super(key: key);

  @override
  State<VideoCatalogPage> createState() => _VideoCatalogPageState();
}

class _VideoCatalogPageState extends State<VideoCatalogPage> {
  bool loaded = false;
  late List<Video> videos;

  @override
  void initState() {
    super.initState();

    Application.videosFetcher.fetch().then(
          (data) => setState(() {
            loaded = true;
            videos = data;
          }),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Catalog'),
        centerTitle: true,
      ),
      body: loaded
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: videos.length,
                itemBuilder: (_, index) {
                  var video = videos[index];

                  return GestureDetector(
                    onTap: () {
                      Application.router.navigateTo(
                        context,
                        VideoPlayerPage.prepareRouteParams(video.id),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AspectRatio(
                        aspectRatio: 3 / 2,
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
                                  gradient: LinearGradient(
                                    begin: const Alignment(0.0, -1.0),
                                    end: const Alignment(0.0, 1.0),
                                    colors: [
                                      Colors.transparent,
                                      Colors.black.withOpacity(0.6),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    video.title,
                                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                          color: Colors.white,
                                        ),
                                  ),
                                  Text(
                                    video.subtitle,
                                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                          color: Colors.white,
                                        ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    video.description,
                                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                          color: Colors.white,
                                        ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          : const LoadingStatusView(),
    );
  }
}
