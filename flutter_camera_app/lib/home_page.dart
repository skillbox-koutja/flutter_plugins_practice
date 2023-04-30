import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_camera_app/camera_widget.dart';
import 'package:flutter_camera_app/gallery_widget.dart';

const cameraView = 0;
const galleryView = 1;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  String get _title => _selectedIndex == cameraView ? CameraWidget.title : GalleryWidget.title;

  List<XFile> _images = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: _selectedIndex == cameraView ? CameraWidget(onTakePicture: _onTakePicture) : GalleryWidget(images: _images),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: 'Camera',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.image),
            label: 'Gallery',
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _addImage(XFile image) => setState(() {
    _images = [..._images, image];
  });

  Future<void> _onTakePicture(XFile? image) async {
    if (image != null) _addImage(image);
  }
}
