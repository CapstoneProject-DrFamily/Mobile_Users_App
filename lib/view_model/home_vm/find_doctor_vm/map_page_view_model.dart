import 'dart:async';
import 'package:drFamily_app/screens/share/base_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';

class MapPageViewModel extends BaseModel {
  CameraPosition _initPosition = CameraPosition(
    target: LatLng(10.7915178, 106.7271422),
    zoom: 11.0,
  );

  bool _isLoading = true;

  Completer<GoogleMapController> _controllerGoogle = Completer();
  GoogleMapController _controller;

  Position _currentPosition;

  TextEditingController _addressController = TextEditingController();

  String _addressText = "";

  double _bottomPadding = 0;

  //getters
  CameraPosition get initPosition => _initPosition;
  Completer<GoogleMapController> get controllerGoogle => _controllerGoogle;
  GoogleMapController get controller => _controller;

  Position get currentPosition => _currentPosition;

  bool get isLoading => _isLoading;

  TextEditingController get addressController => _addressController;

  double get bottomPadding => _bottomPadding;

  MapPageViewModel() {
    _addressController.addListener(() {
      _addressText = _addressController.text;
      notifyListeners();
    });
    initMap();
    Future.microtask(() async {
      await Permission.location.status;
      await Permission.location.request();
      await Permission.location.status.isGranted.then((value) {
        this._isLoading = false;
        notifyListeners();
      });
    });
  }

  void initMap() {}

  void onMapCreated(GoogleMapController controller) {
    _controllerGoogle.complete(controller);
    _controller = controller;

    _bottomPadding = 75;

    notifyListeners();

    locatePosition();
  }

  void locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    this._currentPosition = position;

    LatLng latLngPosition = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition =
        new CameraPosition(target: latLngPosition, zoom: 16);
    _controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    notifyListeners();
  }
}
