import 'package:drFamily_app/global_variable.dart';

class HelperMethod {
  static void disableUpdateDoctorLocation() {
    updateDoctorLocation.pause();
  }

  static void enableUpdateDoctorLocation() {
    updateDoctorLocation.resume();
  }
}
