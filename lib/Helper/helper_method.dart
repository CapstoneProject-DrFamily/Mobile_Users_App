import 'package:drFamily_app/global_variable.dart';

class HelperMethod {
  static void disableUpdateDoctorLocation() {
    updateDoctorLocation.pause();
  }

  static void enableUpdateDoctorLocation() {
    updateDoctorLocation.resume();
  }

  static void disabltransactionStatusUpdate() {
    transactionStatusUpdate.pause();
  }

  static void enabletransactionStatusUpdate() {
    transactionStatusUpdate.resume();
  }

  static void disablUpdateDoctorTransaction() {
    updateDoctorTransaction.pause();
  }

  static void enableUpdateDoctorTransaction() {
    updateDoctorTransaction.resume();
  }

  static void disableTransactionMapUpdates() {
    transactionMapStreamSubscription.pause();
  }

  static void enableTransactionMapUpdates() {
    transactionMapStreamSubscription.resume();
  }

  static void disableupdateDoctorTransactionChecking() {
    updateDoctorTransactionChecking.pause();
  }

  static void enableupdateDoctorTransactionChecking() {
    updateDoctorTransactionChecking.resume();
  }

  static void disableupdateDoctorTransactionSample() {
    updateDoctorTransactionSample.pause();
  }

  static void enableupdateDoctorTransactionSample() {
    updateDoctorTransactionSample.resume();
  }
}
