import 'package:drFamily_app/model/home/find_doctor/map/user_current_address.dart';
import 'package:drFamily_app/model/specialty_service_model.dart';
import 'package:drFamily_app/model/transaction_history_model.dart';
import 'package:drFamily_app/repository/home/find_doctor/map_api/map_screen_repo.dart';
import 'package:drFamily_app/repository/specialty_repo.dart';
import 'package:drFamily_app/repository/transaction_repo.dart';
import 'package:drFamily_app/screens/share/base_model.dart';
import 'package:drFamily_app/view_model/home_vm/time_line/base_time_line_view_model.dart';
import 'package:drFamily_app/view_model/home_vm/time_line_appoinment/base_time_line_appoiment_view_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryCheckingScreenViewModel extends BaseModel {
  ITransactionRepo _transactionRepo = TransactionRepo();
  final IMapScreenRepo _mapRepo = MapScreenRepo();
  final ISpecialtyRepo _specialtyRepo = SpecialtyRepo();

  UserCurrentAddress _pickUpInfo = UserCurrentAddress();

  List<SpecialtyServiceModel> listSpecialty = [];

  bool initHistoryChecking = true;

  int chooseIndex = 0;

  List<TransactionHistoryModel> _listTransaction = [];
  List<TransactionHistoryModel> get listTransaction => _listTransaction;

  SharedPreferences prefs;

  int patientId;

  List<String> diagnoseList = [];

  Future<void> initData() async {
    if (this.initHistoryChecking) {
      prefs = await SharedPreferences.getInstance();

      patientId = prefs.getInt("usPatientID");
      _listTransaction = await getListDoneChecking(patientId);
      listSpecialty = await _specialtyRepo.getAll();

      this.initHistoryChecking = false;
    }
  }

  Future<List<TransactionHistoryModel>> getListDoneChecking(
      int patientId) async {
    List<TransactionHistoryModel> listTransaction = await _transactionRepo
        .getListTransactionHistory(patientId.toString(), 3);

    for (int i = 0; i < listTransaction.length; i++) {
      diagnoseList = [];
      diagnoseList = listTransaction[i].conclusion.split(";");
      listTransaction[i].diagnose = diagnoseList;
    }

    return listTransaction;
  }

  Future<void> confirmChoose(
      BaseTimeLineViewModel baseTimeLineViewModel,
      BaseTimeLineAppoinmentViewModel baseTimeLineAppoinmentViewModel,
      String location,
      TransactionHistoryModel transaction) async {
    var noteHistory = prefs.getString("noteHistory");
    print("note $noteHistory");

    print("serviceId ${transaction.serviceId}");

    var specialtyTemp = listSpecialty.indexWhere((element) =>
        element.listService.indexWhere(
            (element1) => element1.serviceId == transaction.serviceId) !=
        -1);

    SpecialtyServiceModel specialty = listSpecialty[specialtyTemp];

    int indexService = specialty.listService
        .indexWhere((element) => element.serviceId == transaction.serviceId);

    print(
        "service ID:${specialty.listService[indexService].serviceId} default:${specialty.listService[indexService].isDefault} speicaltyID:${specialty.specialtyId} Name:${specialty.name}");

    prefs.setInt("usServiceID", specialty.listService[indexService].serviceId);
    prefs.setString("chooseSpecialty", specialty.name);
    prefs.setInt("chooseSpecialtyId", specialty.specialtyId);
    prefs.setBool(
        "isServiceDefault", specialty.listService[indexService].isDefault);
    prefs.setString("noteHistory", transaction.note);

    LatLng latLngPosition = LatLng(
        double.parse(
            location.toString().split(";")[0].split(",")[0].split(":")[1]),
        double.parse(
            location.toString().split(";")[0].split(",")[1].split(":")[1]));
    String service = prefs.getString("usTransactionStatus");

    _pickUpInfo = await _mapRepo.searchCoordinateAddress(latLngPosition);

    if (service == "booking") {
      baseTimeLineAppoinmentViewModel.nextStep();
    } else {
      baseTimeLineViewModel.pickUpInfo = _pickUpInfo;

      baseTimeLineViewModel.nextStep();
      baseTimeLineViewModel.nextStep();
    }
  }
}
