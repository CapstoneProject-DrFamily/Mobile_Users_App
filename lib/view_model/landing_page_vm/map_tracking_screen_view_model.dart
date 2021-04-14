import 'dart:async';
import 'dart:convert';

import 'package:commons/commons.dart';
import 'package:drFamily_app/Helper/helper_method.dart';
import 'package:drFamily_app/global_variable.dart';
import 'package:drFamily_app/model/transaction_map_model.dart';
import 'package:drFamily_app/model/transaction_map_update_model.dart';
import 'package:drFamily_app/repository/doctor_repo.dart';
import 'package:drFamily_app/repository/notify_repo.dart';
import 'package:drFamily_app/repository/transaction_repo.dart';
import 'package:drFamily_app/screens/home/find_doctor/time_line_examine_page.dart';
import 'package:drFamily_app/screens/share/base_model.dart';
import 'package:drFamily_app/view_model/home_vm/find_doctor_vm/waiting_booking_doctor_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapTrackingScreenViewModel extends BaseModel {
  final IDoctorRepo _doctorRepo = DoctorRepo();
  final ITransactionRepo _transactionRepo = TransactionRepo();
  final INotifyRepo _notifyRepo = NotifyRepo();

  final double _initFabHeight = 260.0;
  double _fabHeight;
  double get fabHeight => _fabHeight;
  double _panelHeightClosed = 240.0;
  double get panelHeightClosed => _panelHeightClosed;

  double _bottomPadding = 0;
  double get bottomPadding => _bottomPadding;

  Position _currentPosition;
  Position get currentPosition => _currentPosition;

  Completer<GoogleMapController> _controllerGoogle = Completer();
  GoogleMapController _controller;

  CameraPosition _initPosition = CameraPosition(
    target: LatLng(10.7915178, 106.7271422),
    zoom: 11.0,
  );
  CameraPosition get initPosition => _initPosition;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Set<Marker> _markers = Set<Marker>();
  Set<Marker> get markers => _markers;

  Position myPosition;

  String durationString;

  FirebaseUser _firebaseuser;

  DatabaseReference _doctorRequest;

  DatabaseReference _transactionRequest;

  String userId;

  String _transactionID;

  TransactionMapModel _transactionMapModel;
  TransactionMapModel get transactionMapModel => _transactionMapModel;

  List<SymptomTempModel> symptomsDisplay = [];
  List<String> titleSymptom = [];

  String doctorFBid;

  String notiToken;

  int _doctorPhoneNum;

  MapTrackingScreenViewModel(String transactionId, String doctorFBID) {
    _transactionID = transactionId;
    WaitingBookingDoctorViewModel.screenStatus = "Map";
    _isLoading = true;
    _fabHeight = _initFabHeight;
    doctorFBid = doctorFBID;
    WaitingBookingDoctorViewModel.doctorFBId = "";
    notifyListeners();
    initMap();
  }

  void initMap() async {
    _firebaseuser = await FirebaseAuth.instance.currentUser();
    userId = _firebaseuser.uid;
    print('doctorFBID $doctorFBid');
    _doctorRequest =
        FirebaseDatabase.instance.reference().child("Doctor Request");

    _transactionRequest =
        FirebaseDatabase.instance.reference().child("Transaction");

    await _doctorRequest
        .child(doctorFBid)
        .once()
        .then((DataSnapshot dataSnapshot) {
      Map<dynamic, dynamic> values = dataSnapshot.value;

      notiToken = values['token'];
    });

    updateDoctorLocation =
        _doctorRequest.child(doctorFBid).onChildChanged.listen(
      (event) {
        if (event.snapshot.value.toString().contains("latitude")) {
          if (event.snapshot.value['latitude'] != null &&
              event.snapshot.value['longtitude'] != null) {
            double latitude = double.parse(event.snapshot.value['latitude']);
            double longitude = double.parse(event.snapshot.value['longtitude']);
            LatLng doctorLatLng = LatLng(latitude, longitude);
            Marker currentDoctorLocation = Marker(
                markerId: MarkerId("doctorLocation"),
                position: doctorLatLng,
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueGreen));
            _markers.add(currentDoctorLocation);
            notifyListeners();
          }
        }
      },
    );

    getTransactionCancelUpdate();

    _transactionMapModel =
        await _transactionRepo.detailTransactionMap(_transactionID);
    //format list symptom to display
    print('stymptom: ${transactionMapModel.patientSymptom.isEmpty}');
    if (_transactionMapModel.patientSymptom.isEmpty) {
      symptomsDisplay = [];
    } else {
      bool first = true;
      SymptomTempModel symptom;
      String sympTitle;
      List<SymptomTempModel> symptomsList = _transactionMapModel.patientSymptom;
      String symptomName;
      for (int i = 0; i < symptomsList.length; i++) {
        if (titleSymptom.contains(symptomsList[i].symptomtype)) {
          if (i == (symptomsList.length - 1)) {
            symptomName = symptomName + symptomsList[i].symptomName;
          } else {
            symptomName = symptomName + symptomsList[i].symptomName + ", ";
          }
          first = false;
        } else {
          if (first == true) {
            titleSymptom.add(symptomsList[i].symptomtype);
            sympTitle = symptomsList[i].symptomtype;
            symptomName = "";
            symptomName = symptomName + symptomsList[i].symptomName + ", ";
          } else {
            first = true;
            symptomName = symptomName.substring(0, symptomName.length - 2);
            symptom = SymptomTempModel(
                symptomtype: sympTitle, symptomName: symptomName);
            symptomsDisplay.add(symptom);
            titleSymptom.add(symptomsList[i].symptomtype);
            sympTitle = symptomsList[i].symptomtype;
            if (i == (symptomsList.length - 1)) {
              symptomName = "";
              symptomName = symptomName + symptomsList[i].symptomName;
            } else {
              symptomName = "";
              symptomName = symptomName + symptomsList[i].symptomName + ", ";
            }
          }
        }
      }
      symptom =
          SymptomTempModel(symptomtype: sympTitle, symptomName: symptomName);
      symptomsDisplay.add(symptom);
    }
    durationString = transactionMapModel.estimateTime;
    var doctorId = transactionMapModel.doctorId;
    _doctorPhoneNum = await _doctorRepo.getDoctorPhoneNum(doctorId);
    getWhenDoctorCome();

    _isLoading = false;
    notifyListeners();
  }

  void getWhenDoctorCome() {
    transactionStatusUpdate = _transactionRequest
        .child(_transactionMapModel.transactionId)
        .onChildAdded
        .listen((event) {
      print('doctor come ${event.snapshot.value}');
      if (event.snapshot.key == "transaction_status") {
        HelperMethod.disabltransactionStatusUpdate();
        HelperMethod.disableUpdateDoctorLocation();
        HelperMethod.disableTransactionMapUpdates();

        TimeLineExamineScreen.transactionID =
            _transactionMapModel.transactionId;
        Get.off(TimeLineExamineScreen());
      }
    });
  }

  void onMapCreated(GoogleMapController controller) {
    _controllerGoogle.complete(controller);
    _controller = controller;

    _bottomPadding = 200;

    notifyListeners();

    locatePosition();
  }

  void locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    this._currentPosition = position;

    LatLng latLngPosition = LatLng(position.latitude, position.longitude);
    print("Position: " +
        position.latitude.toString() +
        " " +
        position.longitude.toString());

    CameraPosition cameraPosition =
        new CameraPosition(target: latLngPosition, zoom: 16);
    _controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    LatLng patienLatLng =
        LatLng(_transactionMapModel.latitude, _transactionMapModel.longitude);
    Marker patientLocation = Marker(
        markerId: MarkerId("patientLocation"),
        position: patienLatLng,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed));
    _markers.add(patientLocation);

    // await _doctorRequest
    //     .child(doctorFBid)
    //     .once()
    //     .then((DataSnapshot dataSnapshot) {
    //   if (dataSnapshot.value == null) {
    //   } else {
    //     var latitude = double.parse(dataSnapshot.value['pickup']["latitude"]);
    //     var longitude =
    //         double.parse(dataSnapshot.value['pickup']["longtitude"]);
    //     LatLng doctorLatLng = LatLng(latitude, longitude);
    //     Marker currentDoctorLocation = Marker(
    //         markerId: MarkerId("doctorLocation"),
    //         position: doctorLatLng,
    //         icon: BitmapDescriptor.defaultMarkerWithHue(
    //             BitmapDescriptor.hueGreen));
    //     _markers.add(currentDoctorLocation);
    //   }
    // });

    notifyListeners();
  }

  void getCurrentPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    this._currentPosition = position;

    LatLng latLngPosition = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition =
        new CameraPosition(target: latLngPosition, zoom: 16);
    _controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    notifyListeners();
  }

  void slidePanel(double pos, BuildContext context) {
    _fabHeight =
        pos * (MediaQuery.of(context).size.height * .80 - _panelHeightClosed) +
            _initFabHeight;
    notifyListeners();
  }

  void cancelTransaction(BuildContext context) async {
    HelperMethod.disabltransactionStatusUpdate();
    HelperMethod.disableUpdateDoctorLocation();
    HelperMethod.disableTransactionMapUpdates();

    TransactionMapUpdateModel transaction = TransactionMapUpdateModel(
        doctorId: _transactionMapModel.doctorId,
        estimatedTime: _transactionMapModel.estimateTime,
        location: _transactionMapModel.location,
        note: _transactionMapModel.transactionNote,
        patientId: _transactionMapModel.patientId,
        status: 4,
        transactionId: _transactionMapModel.transactionId);
    String transactionJson = jsonEncode(transaction.toJson());
    bool cancel = await _transactionRepo.updateTransaction(transactionJson);

    if (cancel) {
      print(notiToken);
      await _transactionRequest
          .child(_transactionMapModel.transactionId)
          .remove();

      _notifyRepo.cancelTransaction(
          _transactionMapModel.transactionId, notiToken);
      Fluttertoast.showToast(
        msg: "You have Canceled",
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.red,
        gravity: ToastGravity.CENTER,
      );
      Navigator.pop(context);
    }
  }

  void callPhone(BuildContext context) async {
    await launch('tel://$_doctorPhoneNum');
    Navigator.pop(context);
  }

  void getTransactionCancelUpdate() {
    transactionMapStreamSubscription =
        _transactionRequest.child(_transactionID).onChildRemoved.listen(
      (event) {
        HelperMethod.disabltransactionStatusUpdate();
        HelperMethod.disableUpdateDoctorLocation();
        HelperMethod.disableTransactionMapUpdates();

        Fluttertoast.showToast(
          msg: "Doctor have Cancel Booking",
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.red,
          gravity: ToastGravity.CENTER,
        );
        Get.back();
      },
    );
  }
}
