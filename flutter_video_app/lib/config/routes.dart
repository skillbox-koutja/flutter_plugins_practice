import 'package:flutter_video_app/config/route_handlers.dart';
import 'package:flutter_video_app/ui/not_found/not_found.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_video_app/ui/video/catalog/page.dart';
import 'package:flutter_video_app/ui/video/player/page.dart';

class Routes {
  static String root = '/';

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = Handler(handlerFunc: (_, __) {
      return const NotFoundPage();
    });
    router.define(root, handler: rootHandler);
    router.define(VideoCatalogPage.routeName, handler: videoCatalogHandler);
    router.define(VideoPlayerPage.routeName, handler: videoPlayerHandler);
  }
}
