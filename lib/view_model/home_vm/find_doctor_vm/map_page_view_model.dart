import 'dart:async';
import 'dart:collection';
import 'package:drFamily_app/model/home/find_doctor/map/place_predictions.dart';
import 'package:drFamily_app/model/home/find_doctor/map/user_current_address.dart';
import 'package:drFamily_app/model/setting/profile_model.dart';
import 'package:drFamily_app/repository/home/find_doctor/map_api/map_screen_repo.dart';
import 'package:drFamily_app/repository/patient_repo.dart';
import 'package:drFamily_app/repository/setting/profile_repo.dart';
import 'package:drFamily_app/screens/share/base_model.dart';
import 'package:drFamily_app/view_model/home_vm/time_line/base_time_line_view_model.dart';
import 'package:drFamily_app/view_model/home_vm/time_line_appoinment/base_time_line_appoiment_view_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapPageViewModel extends BaseModel {
  final IMapScreenRepo _mapRepo = MapScreenRepo();
  final IPatientRepo _patientRepo = PatientRepo();

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

  UserCurrentAddress _pickUpInfo = UserCurrentAddress();

  String _currentSearch = "";

  String locationDone;

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

  String get currentSearch => _currentSearch;

  bool _isEnable = false;
  bool get isEnable => _isEnable;

  bool init = false;

  MapPageViewModel() {
    print("init ${init.toString()}");

    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        _currentSearch = "";
        notifyListeners();
      },
    );

    _addressController.addListener(() {
      _addressText = _addressController.text;
      if (_addressController.text.length == 0) {
        _isEnable = false;
      } else {
        _isEnable = true;
      }
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
    init = true;
  }

  void initMap() async {}

  void onMapCreated(GoogleMapController controller) {
    _isEnable = false;
    _controllerGoogle.complete(controller);
    _controller = controller;

    _bottomPadding = 75;

    notifyListeners();

    locatePosition();
  }

  void locatePosition() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var usPatientID = prefs.getInt("usPatientID");

    String location = await _patientRepo.getPatientLocation(usPatientID);

    _currentSearch = "";

    if (location != null) {
      addressController.text =
          location.toString().split(";")[1].trim().split(":")[1].trim();
      locationDone = location;
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      this._currentPosition = position;

      LatLng latLngPosition = LatLng(
          double.parse(
              location.toString().split(";")[0].split(",")[0].split(":")[1]),
          double.parse(
              location.toString().split(";")[0].split(",")[1].split(":")[1]));
      print("Position: " +
          position.latitude.toString() +
          " " +
          position.longitude.toString());
      _markers = HashSet<Marker>();
      _markers.add(Marker(markerId: MarkerId("0"), position: latLngPosition));

      CameraPosition cameraPosition =
          new CameraPosition(target: latLngPosition, zoom: 16);
      _controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

      _pickUpInfo = await _mapRepo.searchCoordinateAddress(latLngPosition);

      _isEnable = true;
    } else {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      this._currentPosition = position;

      LatLng latLngPosition = LatLng(position.latitude, position.longitude);
      print("Position: " +
          position.latitude.toString() +
          " " +
          position.longitude.toString());
      _markers = HashSet<Marker>();
      _markers.add(Marker(markerId: MarkerId("0"), position: latLngPosition));

      CameraPosition cameraPosition =
          new CameraPosition(target: latLngPosition, zoom: 16);
      _controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

      _pickUpInfo = await _mapRepo.searchCoordinateAddress(latLngPosition);

      _addressController.text = _pickUpInfo.placeName;

      _isEnable = true;
    }

    notifyListeners();
  }

  void getCurrentPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    this._currentPosition = position;

    LatLng latLngPosition = LatLng(position.latitude, position.longitude);
    print("Position: " +
        position.latitude.toString() +
        " " +
        position.longitude.toString());
    _markers = HashSet<Marker>();
    _markers.add(Marker(markerId: MarkerId("0"), position: latLngPosition));

    CameraPosition cameraPosition =
        new CameraPosition(target: latLngPosition, zoom: 16);
    _controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    _pickUpInfo = await _mapRepo.searchCoordinateAddress(latLngPosition);

    _addressController.text = _pickUpInfo.placeName;

    _isEnable = true;
  }

  Future<void> handleTap(LatLng tappedPoint) async {
    _currentSearch = "";

    _pickUpInfo = await _mapRepo.searchCoordinateAddress(tappedPoint);

    _addressController.text = _pickUpInfo.placeName;

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
    _currentSearch = "";
    if (searchValue.length > 1) {
      _currentSearch = searchValue;
      _listAddress = await _mapRepo.searchAddress(searchValue);
      if (_listAddress == null) _listAddress = [];
      // print("Address: " + _listAddress.length.toString());
      notifyListeners();
    }
  }

  Future<void> chooseLocation(String placeId) async {
    _currentSearch = "";

    _pickUpInfo = await _mapRepo.getPlaceAddressDetails(placeId);

    _addressController.text = _pickUpInfo.placeName;

    LatLng latLngPosition =
        LatLng(_pickUpInfo.latitude, _pickUpInfo.longtitude);

    _markers = new HashSet<Marker>();

    _markers.add(
      Marker(
        markerId: MarkerId("0"),
        position: latLngPosition,
      ),
    );

    CameraPosition cameraPosition =
        new CameraPosition(target: latLngPosition, zoom: 16);
    _controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    notifyListeners();
  }

  Future<void> doneMap(
      BuildContext context,
      BaseTimeLineViewModel baseTimeLineViewModel,
      BaseTimeLineAppoinmentViewModel baseTimeLineAppoinmentViewModel) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String service = prefs.getString("usTransactionStatus");

    locationDone =
        'latitude: ${_pickUpInfo.latitude}, longitude: ${_pickUpInfo.longtitude}; placeName: ${_pickUpInfo.placeName}';
    prefs.setString("usLocation", locationDone);

    print("location: $locationDone");

    if (service == "booking") {
      baseTimeLineAppoinmentViewModel.nextStep();
    } else {
      baseTimeLineViewModel.pickUpInfo = _pickUpInfo;

      baseTimeLineViewModel.nextStep();
    }

    // if (transactionStatus.endsWith("booking")) {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => ListDoctorScheduleScreen(
    //         specialityId: prefs.getInt('chooseSpecialtyId'),
    //       ),
    //     ),
    //   );
    // } else {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => ListDoctorPage(
    //         pickUpInfo: _pickUpInfo,
    //       ),
    //     ),
    //   );
    // }
  }
}
