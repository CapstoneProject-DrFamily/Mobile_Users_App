import 'package:drFamily_app/model/dependent_model.dart';
import 'package:drFamily_app/repository/setting/dependent_repo.dart';
import 'package:drFamily_app/screens/setting/dependent_health_record_screen.dart';
import 'package:drFamily_app/screens/setting/dependent_profile_screen.dart';
import 'package:drFamily_app/screens/share/base_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DependentViewModel extends BaseModel {
  final IDependentRepo _patientRepo = DependentRepo();

  List<DependentModel> _listDependent = [];
  List<DependentModel> get listDependent => _listDependent;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  DependentViewModel() {
    getListDependent();
  }

  void getListDependent() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var accountID = prefs.getInt("usAccountID");

    _isLoading = true;
    notifyListeners();

    _listDependent =
        await _patientRepo.getListDependent(accountID).whenComplete(() {
      _isLoading = false;
    });
    notifyListeners();
  }

  void seeDetail(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DependentProfileScreen(),
      ),
    ).then((value) => getListDependent());
  }

  void seeHealthRecord(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DependentHealthRecordScreen(),
      ),
    ).then((value) => getListDependent());
  }
}
