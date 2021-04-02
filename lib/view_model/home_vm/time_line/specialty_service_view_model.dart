import 'package:drFamily_app/model/specialty_service_model.dart';
import 'package:drFamily_app/repository/specialty_repo.dart';
import 'package:drFamily_app/screens/share/base_model.dart';
import 'package:drFamily_app/view_model/home_vm/time_line/base_time_line_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SpecialtyServiceViewModel extends BaseModel {
  final ISpecialtyRepo _specialtyRepo = SpecialtyRepo();

  List<SpecialtyServiceModel> listDislay;

  bool initSpecialty = true;

  int chooseIndex = 0;

  Future<void> initData() async {
    if (this.initSpecialty) {
      listDislay = await _specialtyRepo.getAll();

      this.initSpecialty = false;
    }
  }

  void changeSpecialty(int index) {
    chooseIndex = index;
    notifyListeners();
  }

  void chooseSpecialty(BaseTimeLineViewModel baseTimeLineViewModel,
      int specialtyID, String specialtyName, int serviceId) async {
    print(baseTimeLineViewModel);
    print('serviceId: $serviceId');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("usServiceID", serviceId);
    prefs.setString("chooseSpecialty", specialtyName);
    prefs.setInt("chooseSpecialtyId", specialtyID);

    //next page
    baseTimeLineViewModel.nextStep();
  }
}
