import 'dart:convert';

import 'package:drFamily_app/model/doctor_model.dart';
import 'package:drFamily_app/model/home/find_doctor/map/user_current_address.dart';
import 'package:drFamily_app/screens/share/base_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';

class ListDoctorScreenViewModel extends BaseModel {
  DatabaseReference _doctorRequest;

  List<DoctorModel> _nearByDoctorList = [];
  List<DoctorModel> get nearByDoctorList => _nearByDoctorList;

  UserCurrentAddress _pickUpInfo;
  UserCurrentAddress get pickUpInfo => _pickUpInfo;

  // List<NearbyDoctorModel> _nearByDoctorList = [];
  // List<NearbyDoctorModel> get nearByDoctorList => _nearByDoctorList;

  void init(UserCurrentAddress pickUpInfoRef) {
    this._pickUpInfo = pickUpInfoRef;
    print(_pickUpInfo.placeID);
    print(_pickUpInfo.placeName);
    print("latitude: " +
        _pickUpInfo.latitude.toString() +
        " longtitude: " +
        _pickUpInfo.longtitude.toString());
    getListDoctorNearby();
  }

  Future<List<DoctorModel>> getListDoctorNearby() async {
    _doctorRequest = await FirebaseDatabase.instance
        .reference()
        .child("Doctor Request")
        .once()
        .then((DataSnapshot dataSnapshot) {
      Map<dynamic, dynamic> values = dataSnapshot.value;
      values.forEach((key, values) async {
        // print(values['pickup']['latitude']);
        final double distance = await Geolocator.distanceBetween(
            _pickUpInfo.latitude,
            _pickUpInfo.longtitude,
            double.parse(values['pickup']['latitude']),
            double.parse(values['pickup']['longtitude']));
        if ((distance / 1000) <= 5) {
          DoctorModel tDoctor = DoctorModel(
            notitoken: values['token'],
            id: int.parse(values['doctor_id']),
            image: values['doctor_image'],
            name: values['doctor_name'],
            speciality: values['doctor_specialty'],
            year: 0,
            latitude: double.parse(values['pickup']['latitude']),
            longitude: double.parse(values['pickup']['longtitude']),
            distance: double.parse((distance / 1000).toStringAsFixed(1)),
          );

          print(distance / 1000);
          _nearByDoctorList.add(tDoctor);
        }
      });
    });
    notifyListeners();
  }
}
