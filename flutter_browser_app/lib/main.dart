import 'package:flutter/material.dart';
import 'package:flutter_browser_app/internet_explorer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Browser App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const InternetExplorer(),
    );
  }
}
