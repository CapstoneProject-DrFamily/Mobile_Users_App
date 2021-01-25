import 'package:drFamily_app/screens/share/base_model.dart';

class TimeLineExamineViewModel extends BaseModel {
  int _currentStep = 0;

  int get currentStep => _currentStep;

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
