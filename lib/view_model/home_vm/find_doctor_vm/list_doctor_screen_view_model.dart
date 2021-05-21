import 'package:drFamily_app/model/doctor_model.dart';
import 'package:drFamily_app/model/home/find_doctor/map/user_current_address.dart';
import 'package:drFamily_app/repository/app_config_repo.dart';
import 'package:drFamily_app/repository/doctor_repo.dart';
import 'package:drFamily_app/screens/home/doctor_detail_screen.dart';
import 'package:drFamily_app/screens/share/base_model.dart';
import 'package:drFamily_app/view_model/home_vm/time_line/base_time_line_view_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListDoctorScreenViewModel extends BaseModel {
  final IAppConfigRepo _appConfigRepo = AppConfigRepo();
  final IDoctorRepo _doctorRepo = DoctorRepo();

  DatabaseReference _doctorRequest;

  List<DoctorModel> _nearByDoctorList = [];
  List<DoctorModel> get nearByDoctorList => _nearByDoctorList;

  List<DoctorModel> _listNearbyDoctorTemp = [];

  UserCurrentAddress _pickUpInfo;
  UserCurrentAddress get pickUpInfo => _pickUpInfo;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  bool _isNotHave = false;
  bool get isNotHave => _isNotHave;

  bool loadBack = false;

  List<String> listSort = ["Doctor Distance", "Old Doctor", "Doctor Booked"];
  int status = 0;

  int accountId;
  int specialtyId;
  bool isDefault;
  int doctorDefaultId;

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

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      accountId = prefs.getInt('usAccountID');
      specialtyId = prefs.getInt('chooseSpecialtyId');
      isDefault = prefs.getBool("isServiceDefault");

      doctorDefaultId = prefs.getInt("chooseDoctorId");

      print("accountId $accountId $specialtyId $isDefault $doctorDefaultId");

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
      _isLoading = false;
      _isNotHave = true;
    } else {
      Comparator<DoctorModel> distanceComparator =
          (a, b) => a.distance.compareTo(b.distance);
      _nearByDoctorList.sort(distanceComparator);

      //list to compare old doctor
      _listNearbyDoctorTemp = _nearByDoctorList;
      print('change list ${_listNearbyDoctorTemp.length}');
      _isNotHave = false;
      _isLoading = false;
    }
    notifyListeners();
  }

  Future<void> getListOldDoctor(int specialtyID, int accountID) async {
    List<DoctorModel> listOldDoctorTemp = [];
    if (isDefault) {
      listOldDoctorTemp = await _doctorRepo.getListOldFindDoctor(accountId, -1);
    } else {
      listOldDoctorTemp =
          await _doctorRepo.getListOldFindDoctor(accountId, specialtyID);
    }

    if (listOldDoctorTemp == null) {}

    if (listOldDoctorTemp.length == null) {
      _nearByDoctorList = [];
      _isLoading = false;
      _isNotHave = true;
    } else {
      print("list ${_listNearbyDoctorTemp.length}");
      for (int i = 0; i < listOldDoctorTemp.length; i++) {
        var value = _listNearbyDoctorTemp.firstWhere(
            (element) => element.id == listOldDoctorTemp[i].id,
            orElse: () => null);

        if (value == null) {
          listOldDoctorTemp[i].isOnline = false;
        } else {
          listOldDoctorTemp[i].fbId = value.fbId;
          listOldDoctorTemp[i].notitoken = value.notitoken;
          listOldDoctorTemp[i].distance = value.distance;
          listOldDoctorTemp[i].isOnline = true;
        }
      }
      _nearByDoctorList = listOldDoctorTemp;

      _nearByDoctorList.sort((a, b) {
        if (b.isOnline) {
          return 1;
        }
        return -1;
      });

      if (doctorDefaultId != null) {
        DoctorModel doctormodel = _nearByDoctorList
            .firstWhere((element) => element.id == doctorDefaultId);
        _nearByDoctorList
            .removeWhere((element) => element.id == doctorDefaultId);
        _nearByDoctorList.insert(0, doctormodel);
      }

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
          await getListOldDoctor(specialtyId, accountId);

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
          _nearByDoctorList = _listNearbyDoctorTemp;

          //API get List;

          // _listTransaction = await transactionRepo.getListTransactionHistory(
          //     _patientId.toString(), 2);
          if (_nearByDoctorList.length == 0) {
            _isNotHave = true;
          } else {
            Comparator<DoctorModel> distanceComparator =
                (a, b) => a.booked.compareTo(b.booked);
            _nearByDoctorList.sort(distanceComparator);
            _isNotHave = false;
          }

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
    print("id $id notiToken $notiToken fbId $fbId");
    baseTimeLineViewModel.id = id;
    baseTimeLineViewModel.fbId = fbId;
    baseTimeLineViewModel.notiToken = notiToken;
    baseTimeLineViewModel.nextStep();
  }
}
