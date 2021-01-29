import 'package:drFamily_app/screens/share/base_model.dart';

class HealthRecordViewModel extends BaseModel {
  int _choiceCigarette = 0;
  int _choiceWine = 0;
  int _choiceDrug = 0;
  int _choiceActivity = 0;

  int get choiceCigarette => _choiceCigarette;
  int get choiceWine => _choiceWine;
  int get choiceDrug => _choiceDrug;
  int get choiceActivity => _choiceActivity;

  void changeChoiceCigarette(int newChoice) {
    _choiceCigarette = newChoice;
    notifyListeners();
  }

  void changeChoiceWine(int newChoice) {
    _choiceWine = newChoice;
    notifyListeners();
  }

  void changeChoiceDrug(int newChoice) {
    _choiceDrug = newChoice;
    notifyListeners();
  }

  void changeChoiceActivity(int newChoice) {
    _choiceActivity = newChoice;
    notifyListeners();
  }
}
