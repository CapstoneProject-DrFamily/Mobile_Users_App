import 'package:drFamily_app/model/doctor_model.dart';
import 'package:drFamily_app/model/home/find_doctor/map/user_current_address.dart';
import 'package:drFamily_app/screens/home/doctor_detail_screen.dart';
import 'package:drFamily_app/screens/share/base_model.dart';
import 'package:drFamily_app/view_model/home_vm/time_line/base_time_line_view_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListDoctorScreenViewModel extends BaseModel {
  DatabaseReference _doctorRequest;

  List<DoctorModel> _nearByDoctorList = [];
  List<DoctorModel> get nearByDoctorList => _nearByDoctorList;

  UserCurrentAddress _pickUpInfo;
  UserCurrentAddress get pickUpInfo => _pickUpInfo;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  bool _isNotHave = false;
  bool get isNotHave => _isNotHave;

  Future<void> init(UserCurrentAddress pickUpInfoRef) async {
    if (isLoading) {
      _nearByDoctorList = [];
      this._pickUpInfo = pickUpInfoRef;
      print(_pickUpInfo.placeID);
      print(_pickUpInfo.placeName);
      print("latitude: " +
          _pickUpInfo.latitude.toString() +
          " longtitude: " +
          _pickUpInfo.longtitude.toString());
      await getListDoctorNearby();
    }
  }

  Future<void> getListDoctorNearby() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int serviceID = prefs.getInt("usServiceID");

    _doctorRequest =
        FirebaseDatabase.instance.reference().child("Doctor Request");
    print("oke");

    await _doctorRequest.once().then(
      (DataSnapshot dataSnapshot) {
        print('data $dataSnapshot');
        Map<dynamic, dynamic> values = dataSnapshot.value;
        print("value $values");
        if (values == null) {
          _nearByDoctorList = [];
        } else {
          values.forEach(
            (key, values) {
              // print(values['pickup']['latitude']);
              final double distance = Geolocator.distanceBetween(
                  _pickUpInfo.latitude,
                  _pickUpInfo.longtitude,
                  double.parse(values['pickup']['latitude']),
                  double.parse(values['pickup']['longtitude']));
              var doctorStatus = values['doctor_status'];
              var doctorSpecialty = values['doctor_specialty'];

              if (serviceID == 1) {
                if ((distance / 1000) <= 5 && doctorStatus == "waiting") {
                  DoctorModel tDoctor = DoctorModel(
                    fbId: key,
                    notitoken: values['token'],
                    id: int.parse(values['doctor_id']),
                    image: values['doctor_image'],
                    name: values['doctor_name'],
                    speciality: doctorSpecialty,
                    year: 0,
                    latitude: double.parse(values['pickup']['latitude']),
                    longitude: double.parse(values['pickup']['longtitude']),
                    distance:
                        double.parse((distance / 1000).toStringAsFixed(1)),
                    booked: values['doctor_booked_count'],
                    feedback: values['doctor_feedback_count'],
                    ratingPoint: double.parse(
                        values['doctor_raiting_point'].toStringAsFixed(1)),
                    service: values['doctor_service_id'],
                  );

                  _nearByDoctorList.add(tDoctor);
                }
              } else {
                var specialtyName = prefs.getString("chooseSpecialty");
                if ((distance / 1000) <= 5 &&
                    doctorStatus == "waiting" &&
                    doctorSpecialty == specialtyName) {
                  DoctorModel tDoctor = DoctorModel(
                    fbId: key,
                    notitoken: values['token'],
                    id: int.parse(values['doctor_id']),
                    image: values['doctor_image'],
                    name: values['doctor_name'],
                    speciality: values['doctor_specialty'],
                    year: 0,
                    latitude: double.parse(values['pickup']['latitude']),
                    longitude: double.parse(values['pickup']['longtitude']),
                    distance:
                        double.parse((distance / 1000).toStringAsFixed(1)),
                    booked: values['doctor_booked_count'],
                    feedback: values['doctor_feedback_count'],
                    ratingPoint: double.parse(
                        values['doctor_raiting_point'].toStringAsFixed(1)),
                    service: values['doctor_service_id'],
                  );

                  _nearByDoctorList.add(tDoctor);
                }
              }
            },
          );
        }
      },
    );

    if (_nearByDoctorList.length == 0) {
      Comparator<DoctorModel> distanceComparator =
          (a, b) => a.distance.compareTo(b.distance);
      _nearByDoctorList.sort(distanceComparator);

      _isLoading = false;
      _isNotHave = true;
    } else {
      _isNotHave = false;
      _isLoading = false;
    }
    notifyListeners();
  }

  void getDetailDoctor(int id, String notiToken, String fbId,
      BaseTimeLineViewModel baseTimeLineViewModel) {
    baseTimeLineViewModel.id = id;
    baseTimeLineViewModel.fbId = fbId;
    baseTimeLineViewModel.notiToken = notiToken;
    baseTimeLineViewModel.nextStep();
  }
}
