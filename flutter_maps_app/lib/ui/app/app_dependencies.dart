import 'package:flutter/material.dart';
import 'package:flutter_maps_app/ui/app/app.dart';
import 'package:flutter_maps_app/ui/map_screen/m.dart';
import 'package:flutter_maps_app/utils/error/default_error_handler.dart';
import 'package:provider/provider.dart';

/// Widget with dependencies that live all runtime.
class AppDependencies extends StatefulWidget {
  final App app;

  const AppDependencies({required this.app, super.key});

  @override
  State<AppDependencies> createState() => _AppDependenciesState();
}

class _AppDependenciesState extends State<AppDependencies> {
  late final DefaultErrorHandler _defaultErrorHandler;
  late final MapScreenModel _mapScreenModel;

  @override
  void initState() {
    super.initState();

    _defaultErrorHandler = DefaultErrorHandler();

    _mapScreenModel = MapScreenModel(
      _defaultErrorHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<MapScreenModel>(
          create: (_) => _mapScreenModel,
        ),
      ],
      child: widget.app,
    );
  }
}
