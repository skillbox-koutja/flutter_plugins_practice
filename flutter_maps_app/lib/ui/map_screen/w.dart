import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_maps_app/ui/map_screen/widgets/map_controls.dart';
import 'package:flutter_maps_app/ui/map_screen/wm.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

GlobalKey _mapKey = GlobalKey();

/// Widget screen with list of countries.
class MapScreen extends ElementaryWidget<IMapWidgetModel> {
  const MapScreen({
    Key? key,
    WidgetModelFactory wmFactory = screenWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IMapWidgetModel wm) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map app'),
      ),
      body: Stack(
        children: [
          YandexMap(
            key: _mapKey,
            mapType: MapType.map,
            logoAlignment: const MapAlignment(
              horizontal: HorizontalAlignment.right,
              vertical: VerticalAlignment.bottom,
            ),
            onMapCreated: wm.onMapCreated,
          ),
          EntityStateNotifierBuilder<bool>(
            listenableEntityState: wm.initializingState,
            loadingBuilder: (_, __) => const _LoadingWidget(),
            errorBuilder: (_, __, ___) => const _ErrorWidget(),
            builder: (_, countries) => Positioned.fill(
              child: _MapControls(
                wm: wm,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('loading'),
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  const _ErrorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Error'),
    );
  }
}

class _MapControls extends StatelessWidget {
  final IMapWidgetModel wm;

  const _MapControls({
    required this.wm,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(
        bottom: MediaQuery.of(context).padding.bottom + 16,
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 100,
            right: 0,
            child: _MoveControls(wm: wm),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: _ZoomControls(wm: wm),
          ),
        ],
      ),
    );
  }
}

class _MoveControls extends StatelessWidget {
  final IMapWidgetModel wm;

  const _MoveControls({
    required this.wm,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MoveUpControl(onTap: wm.moveUp),
          ],
        ),
        const SizedBox(height: 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MoveLeftControl(onTap: wm.moveLeft),
            const SizedBox(width: 2),
            HomeControl(onTap: wm.moveToHome),
            const SizedBox(width: 2),
            MoveRightControl(onTap: wm.moveRight),
          ],
        ),
        const SizedBox(height: 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MoveDownControl(onTap: wm.moveDown),
          ],
        ),
      ],
    );
  }
}

class _ZoomControls extends StatelessWidget {
  final IMapWidgetModel wm;

  const _ZoomControls({
    required this.wm,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ZoomOutControl(onTap: wm.zoomOut),
        EntityStateNotifierBuilder<ZoomState>(
          listenableEntityState: wm.zoomState,
          builder: (_, zoom) => SizedBox(
            height: 50,
            width: 150,
            child: Slider.adaptive(
              value: zoom!.current,
              min: zoom.min,
              max: zoom.max,
              divisions: 100,
              onChanged: wm.zoomTo,
            ),
          ),
        ),
        ZoomInControl(onTap: wm.zoomIn),
      ],
    );
  }
}
