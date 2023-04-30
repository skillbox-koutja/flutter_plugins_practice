import 'package:flutter_video_app/config/application.dart';
import 'package:flutter_video_app/config/routes.dart';
import 'package:flutter_video_app/ui/status_view/status_view.dart';
import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Application.router.navigateTo(
          context,
          Routes.root,
        );
      },
      child: const ErrorStatusView(errorMessage: 'Route was not found !!!'),
    );
  }
}
