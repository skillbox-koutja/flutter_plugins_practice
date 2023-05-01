import 'package:flutter/material.dart';
import 'package:flutter_maps_app/ui/app/app.dart';
import 'package:flutter_maps_app/ui/app/app_dependencies.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const AppDependencies(
      app: App(),
    ),
  );
}
