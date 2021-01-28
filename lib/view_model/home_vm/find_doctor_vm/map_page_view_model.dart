import 'dart:async';
import 'dart:collection';
import 'package:drFamily_app/model/home/find_doctor/map/place_predictions.dart';
import 'package:drFamily_app/model/home/find_doctor/map/user_current_address.dart';
import 'package:drFamily_app/repository/home/find_doctor/map_api/map_screen_repo.dart';
import 'package:drFamily_app/screens/share/base_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';

class MapPageViewModel extends BaseModel {
  final IMapScreenRepo _mapRepo = MapScreenRepo();

  CameraPosition _initPosition = CameraPosition(
    target: LatLng(10.7915178, 106.7271422),
    zoom: 11.0,
  );

  bool _isLoading = true;

  Set<Marker> _markers = HashSet<Marker>();

  Completer<GoogleMapController> _controllerGoogle = Completer();
  GoogleMapController _controller;

  Position _currentPosition;

  TextEditingController _addressController = TextEditingController();

  String _addressText = "";

  double _bottomPadding = 0;

  List<PlacePredictions> _listAddress = [];

  //getters
  CameraPosition get initPosition => _initPosition;
  Completer<GoogleMapController> get controllerGoogle => _controllerGoogle;
  GoogleMapController get controller => _controller;

  Position get currentPosition => _currentPosition;

  bool get isLoading => _isLoading;

  TextEditingController get addressController => _addressController;

  double get bottomPadding => _bottomPadding;

  Set<Marker> get markers => _markers;

  List<PlacePredictions> get listAddress => _listAddress;

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

    _markers = HashSet<Marker>();
    _markers.add(Marker(markerId: MarkerId("0"), position: latLngPosition));

    CameraPosition cameraPosition =
        new CameraPosition(target: latLngPosition, zoom: 16);
    _controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    UserCurrentAddress pickUpInfo =
        await _mapRepo.searchCoordinateAddress(latLngPosition);
    print(pickUpInfo.placeName);
    _addressController.text = pickUpInfo.placeName;

    notifyListeners();
  }

  Future<void> handleTap(LatLng tappedPoint) async {
    UserCurrentAddress pickUpInfo =
        await _mapRepo.searchCoordinateAddress(tappedPoint);

    _addressController.text = pickUpInfo.placeName;

    _markers = new HashSet<Marker>();
    _markers.add(
      Marker(
        markerId: MarkerId(tappedPoint.toString()),
        position: tappedPoint,
      ),
    );
    notifyListeners();
  }

  Future<void> searchPlace(String searchValue) async {
    if (searchValue.length > 1) {
      _listAddress = await _mapRepo.searchAddress(searchValue);
    }
  }
}
