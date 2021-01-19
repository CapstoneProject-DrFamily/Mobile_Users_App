import 'dart:async';
import 'package:drFamily_app/screens/share/base_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPageViewModel extends BaseModel {
  CameraPosition _initPosition = CameraPosition(
    target: LatLng(10.7915178, 106.7271422),
    zoom: 11.0,
  );

  bool _isLoading = false;

  Completer<GoogleMapController> _controllerGoogle = Completer();
  GoogleMapController _controller;

  Position _currentPosition;

  //getters
  CameraPosition get initPosition => _initPosition;
  Completer<GoogleMapController> get controllerGoogle => _controllerGoogle;
  GoogleMapController get controller => _controller;

  Position get currentPosition => _currentPosition;

  bool get isLoading => _isLoading;

  MapPageViewModel() {
    initMap();
  }

  void initMap() {}

  void onMapCreated(GoogleMapController controller) {
    _controllerGoogle.complete(controller);
    _controller = controller;
    notifyListeners();

    locatePosition();
  }

  void locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    this._currentPosition = position;

    LatLng latLngPosition = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition =
        new CameraPosition(target: latLngPosition, zoom: 14);
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    notifyListeners();
  }
}
