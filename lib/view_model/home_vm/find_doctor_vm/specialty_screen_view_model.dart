import 'package:drFamily_app/model/specialty_model.dart';
import 'package:drFamily_app/repository/specialty_repo.dart';
import 'package:drFamily_app/screens/home/find_doctor/map_page.dart';
import 'package:drFamily_app/screens/share/base_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SpecialtyScreenViewModel extends BaseModel {
  final ISpecialtyRepo _specialtyRepo = SpecialtyRepo();

  List<SpecialtyModel> _listSpecialty = [];
  List<SpecialtyModel> get listSpecialty => _listSpecialty;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isNotHave = false;
  bool get isNotHave => _isNotHave;

  SpecialtyScreenViewModel() {
    getListSpecialty();
  }

  Future<void> getListSpecialty() async {
    this._isLoading = true;
    notifyListeners();

    _listSpecialty = await _specialtyRepo.getAllSpecialty().whenComplete(() {
      this._isLoading = false;
      notifyListeners();
    });
    print(_listSpecialty);

    if (_listSpecialty == null) {
      _isNotHave = true;
      notifyListeners();
    }
  }

  void chooseSpecialty(BuildContext context, int specialtyID,
      String specialtyName, int serviceId) async {
    print('serviceId: $serviceId');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("usServiceID", serviceId);
    prefs.setString("chooseSpecialty", specialtyName);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MapScreen()),
    );
  }
}
