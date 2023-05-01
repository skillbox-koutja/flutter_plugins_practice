import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_maps_app/ui/map_screen/m.dart';
import 'package:flutter_maps_app/ui/map_screen/w.dart';
import 'package:provider/provider.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

/// Factory for [MapScreenWidgetModel]
MapScreenWidgetModel screenWidgetModelFactory(
  BuildContext context,
) {
  final model = context.read<MapScreenModel>();

  return MapScreenWidgetModel(model);
}

class ZoomState {
  final double min;
  final double max;
  final double current;

  const ZoomState(this.min, this.current, this.max);

  ZoomState zoomTo(double zoom) {
    return ZoomState(min, zoom, max);
  }

  factory ZoomState.empty() {
    return const ZoomState(0, 0.5, 1);
  }
}

const shift = 0.005;

class Direction {
  double get dx => offset.dx;
  double get dy => offset.dy;

  final Offset offset;
  const Direction(this.offset);

  static Direction up = const Direction(Offset(0, 1 * shift));
  static Direction down = const Direction(Offset(0, -1 * shift));
  static Direction right = const Direction(Offset(1 * shift, 0));
  static Direction left = const Direction(Offset(-1 * shift, 0));
}

/// Widget Model for [MapScreen]
class MapScreenWidgetModel extends WidgetModel<MapScreen, MapScreenModel> implements IMapWidgetModel {
  final _initializingState = EntityStateNotifier<bool>(const EntityState(data: true));
  final _zoomState = EntityStateNotifier<ZoomState>(EntityState(data: ZoomState.empty()));

  @override
  ListenableState<EntityState<bool>> get initializingState => _initializingState;

  @override
  ListenableState<EntityState<ZoomState>> get zoomState => _zoomState;
  double get zoom => _zoomState.value?.data?.current ?? 15;

  late YandexMapController _mapController;

  MapScreenWidgetModel(
    MapScreenModel model,
  ) : super(model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
  }

  @override
  void onErrorHandle(Object error) {
    super.onErrorHandle(error);
  }

  @override
  void onMapCreated(YandexMapController mapController) {
    _mapController = mapController;

    Future.wait([
      _mapController.getMinZoom(),
      _mapController.getMaxZoom(),
    ]).then((value) {
      final min = value[0];
      final max = value[1];
      final current = (max - min) / 2;

      moveToHome();
      _zoomState.content(ZoomState(min, current, max));
      _initializingState.content(true);
    });
  }

  @override
  void moveToHome() {
    const location = Point(latitude: 55.796127, longitude: 49.106414);

    _mapController.moveCamera(
      CameraUpdate.newCameraPosition(CameraPosition(
        target: location,
        zoom: zoom,
      )),
    );
  }

  @override
  void zoomIn() {
    _mapController.moveCamera(CameraUpdate.zoomIn()).then((_) {
      _syncZoom();
    });
  }

  @override
  void zoomOut() {
    _mapController.moveCamera(CameraUpdate.zoomOut()).then((_) {
      _syncZoom();
    });
  }

  @override
  void zoomTo(double value) {
    _mapController.moveCamera(CameraUpdate.zoomTo(value)).then((_) {
      _syncZoom();
    });
  }

  @override
  void moveUp() {
    _move(Direction.up);
  }

  @override
  void moveDown() {
    _move(Direction.down);
  }

  @override
  void moveLeft() {
    _move(Direction.left);
  }

  @override
  void moveRight() {
    _move(Direction.right);
  }

  Future<void> _syncZoom() async {
    final pos = await _mapController.getCameraPosition();
    final prevState = _zoomState.value?.data;

    debugPrint('prevState ${prevState == null}');
    if (prevState == null) {
      return;
    }

    _zoomState.content(prevState.zoomTo(pos.zoom));
  }

  Future<void> _move(Direction target) async {
    _mapController.getCameraPosition().then((pos) {
      _mapController.moveCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Point(
            latitude: pos.target.latitude + target.dy,
            longitude: pos.target.longitude + target.dx,
          ),
          zoom: zoom,
        ),
      ));
    });
  }
}

/// Interface of [MapScreenWidgetModel]
abstract class IMapWidgetModel extends IWidgetModel {
  ListenableState<EntityState<bool>> get initializingState;

  ListenableState<EntityState<ZoomState>> get zoomState;

  void onMapCreated(YandexMapController mapController);

  void zoomIn();

  void zoomOut();

  void zoomTo(double value);

  void moveToHome();

  void moveUp();

  void moveDown();

  void moveLeft();

  void moveRight();
}
