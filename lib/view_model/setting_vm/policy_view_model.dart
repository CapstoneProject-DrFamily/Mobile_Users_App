import 'package:drFamily_app/repository/app_config_repo.dart';
import 'package:drFamily_app/screens/share/base_model.dart';

class PolicyViewModel extends BaseModel {
  bool init = true;
  String htmlData;
  AppConfigRepo _appConfigRepo = AppConfigRepo();
  fetchPolicy() async {
    if (init) {
      this.htmlData = await _appConfigRepo.getPolicy();
      init = false;
      notifyListeners();
    }
  }
}
