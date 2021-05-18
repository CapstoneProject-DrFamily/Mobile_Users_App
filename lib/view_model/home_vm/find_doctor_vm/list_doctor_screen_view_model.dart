import 'package:drFamily_app/model/doctor_model.dart';
import 'package:drFamily_app/model/home/find_doctor/map/user_current_address.dart';
import 'package:drFamily_app/repository/app_config_repo.dart';
import 'package:drFamily_app/screens/home/doctor_detail_screen.dart';
import 'package:drFamily_app/screens/share/base_model.dart';
import 'package:drFamily_app/view_model/home_vm/time_line/base_time_line_view_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListDoctorScreenViewModel extends BaseModel {
  final IAppConfigRepo _appConfigRepo = AppConfigRepo();
  DatabaseReference _doctorRequest;

  List<DoctorModel> _nearByDoctorList = [];
  List<DoctorModel> get nearByDoctorList => _nearByDoctorList;

  UserCurrentAddress _pickUpInfo;
  UserCurrentAddress get pickUpInfo => _pickUpInfo;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  bool _isNotHave = false;
  bool get isNotHave => _isNotHave;

  bool loadBack = false;

  List<String> listSort = ["Distance", "Old Doctor", "More"];
  int status = 0;

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

  void loadBackList() async {
    loadBack = true;
    notifyListeners();
    switch (status) {
      case 0:
        {
          _nearByDoctorList = [];
          await getListDoctorNearby();
        }
        break;
      case 1:
        {
          _nearByDoctorList = [];
        }
        break;
      case 2:
        {
          _nearByDoctorList = [];
        }
        break;
      default:
    }

    loadBack = false;
    notifyListeners();
  }

  Future<void> getListDoctorNearby() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int distanceBetween = await _appConfigRepo.getDistance();
    print("distance $distanceBetween");
    int serviceID = prefs.getInt("usServiceID");
    bool isDefault = prefs.getBool("isServiceDefault");

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

              if (isDefault) {
                if ((distance / 1000) <= distanceBetween &&
                    doctorStatus == "waiting") {
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
                if ((distance / 1000) <= distance &&
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

  void changeStatus(int status) async {
    switch (status) {
      case 0:
        {
          _isNotHave = false;

          loadBack = true;
          this.status = status;
          notifyListeners();
          //API get List;
          _nearByDoctorList = [];
          await getListDoctorNearby();

          // _listTransaction = await transactionRepo.getListTransactionHistory(
          //     _patientId.toString(), -1);

          loadBack = false;
          //catch null;

          // if (_listTransaction == null) {
          //   _isNotHave = true;
          // }

          notifyListeners();
        }

        break;
      case 1:
        {
          _isNotHave = false;

          loadBack = true;
          this.status = status;
          notifyListeners();
          _nearByDoctorList = [];

          //API get List;

          // _listTransaction = await transactionRepo.getListTransactionHistory(
          //     _patientId.toString(), 1);

          loadBack = false;
          //catch null;

          // if (_listTransaction == null) {
          //   _isNotHave = true;
          // }

          notifyListeners();
        }

        break;
      case 2:
        {
          _isNotHave = false;

          loadBack = true;
          this.status = status;
          notifyListeners();
          _nearByDoctorList = [];

          //API get List;

          // _listTransaction = await transactionRepo.getListTransactionHistory(
          //     _patientId.toString(), 2);

          loadBack = false;
          //catch null;

          // if (_listTransaction == null) {
          //   _isNotHave = true;
          // }

          notifyListeners();
        }

        break;
      default:
        break;
    }
  }

  void getDetailDoctor(int id, String notiToken, String fbId,
      BaseTimeLineViewModel baseTimeLineViewModel) {
    baseTimeLineViewModel.id = id;
    baseTimeLineViewModel.fbId = fbId;
    baseTimeLineViewModel.notiToken = notiToken;
    baseTimeLineViewModel.nextStep();
  }
}
