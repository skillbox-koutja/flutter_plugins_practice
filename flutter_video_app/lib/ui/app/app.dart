import 'package:flutter_video_app/config/application.dart';
import 'package:flutter_video_app/config/routes.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_video_app/domain/video/videos_fetcher.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  AppState() {
    final router = FluroRouter();
    Routes.configureRoutes(router);
    Application.router = router;
    Application.videosFetcher = VideosFetcher();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Video App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          color: Colors.black26,
        ),
        scaffoldBackgroundColor: Colors.black12,
        useMaterial3: true,
      ),
      onGenerateRoute: Application.router.generator,
    );
  }
}
