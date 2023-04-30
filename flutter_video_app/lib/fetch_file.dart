import 'package:flutter/services.dart';
import 'dart:convert';

Future<String> fetchContentFileFromAssets(String assetsPath) async {
  return rootBundle.loadString(assetsPath);
}

Future<dynamic> fetchJsonFromAssetsFile(String assetsPath) async {
  dynamic response = await fetchContentFileFromAssets(assetsPath);

  return jsonDecode(response);
}
