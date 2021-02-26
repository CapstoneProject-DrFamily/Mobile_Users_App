import 'package:drFamily_app/Helper/pushnotifycation_service.dart';
import 'package:drFamily_app/screens/share/base_model.dart';

class TimeLineExamineViewModel extends BaseModel {
  int _currentStep = 0;

  int get currentStep => _currentStep;

  TimeLineExamineViewModel() {
    PushNotifycationService.usStatus = "Analysis Symptom";
  }

  void continueStep() {
    print('in');
    this._currentStep += 1;
    print(_currentStep);
    notifyListeners();
  }

  void backStep() {
    this._currentStep -= 1;
    notifyListeners();
  }
}
