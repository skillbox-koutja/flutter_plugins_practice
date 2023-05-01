import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraWidget extends StatefulWidget {
  static const title = 'Camera preview';
  final Future<void> Function(XFile? image) onTakePicture;

  const CameraWidget({
    super.key,
    required this.onTakePicture,
  });

  @override
  State<CameraWidget> createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> with WidgetsBindingObserver {
  List<CameraDescription> cameras = [];
  CameraController? controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    unawaited(_initCamera());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _initializeCameraController(cameraController.description);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isInitialized = controller?.value.isInitialized ?? false;

    if (!isInitialized) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      body: SizedBox.expand(
        child: CameraPreview(controller!),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _takePicture,
        child: const Icon(Icons.camera),
      ),
    );
  }

  Future<void> _initCamera() async {
    cameras = await availableCameras();
    controller = CameraController(cameras[0], ResolutionPreset.max);

    try {
      await controller!.initialize();
      if (!mounted) {
        return;
      }
      setState(() {});
    } on CameraException catch (e) {
      debugPrint('${e.code} ${e.description}');
    }
  }

  Future<void> _takePicture() async {
    XFile? image = await controller?.takePicture();

    widget.onTakePicture(image);
  }

  Future<void> _initializeCameraController(CameraDescription cameraDescription) async {
    final CameraController cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.max,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    controller = cameraController;

    // If the controller is updated then update the UI.
    cameraController.addListener(() {
      if (mounted) {
        setState(() {});
      }
      if (cameraController.value.hasError) {
        debugPrint('Camera error ${cameraController.value.errorDescription}');
      }
    });

    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      debugPrint('${e.code} ${e.description}');
    }

    if (mounted) {
      setState(() {});
    }
  }
}
