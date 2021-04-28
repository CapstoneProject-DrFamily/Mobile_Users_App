import 'package:drFamily_app/Helper/helper_method.dart';
import 'package:drFamily_app/screens/home/find_doctor/time_line_examine_page.dart';
import 'package:drFamily_app/screens/share/base_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:drFamily_app/global_variable.dart';
import 'package:get/get.dart';

class AwaitingSampleViewModel extends BaseModel {
  DatabaseReference _transactionRequest;

  bool isLoading = true;

  AwaitingSampleViewModel() {
    init();
  }

  void init() {
    print("first");
    _transactionRequest =
        FirebaseDatabase.instance.reference().child("Transaction");
  }

  Future<void> fetchData(String transactionID) async {
    if (this.isLoading) {
      print("fetch");
      print("transactionID $transactionID");
      updateDoctorTransactionSample =
          _transactionRequest.child(transactionID).onChildChanged.listen(
        (event) {
          print("change");
          print("event value: " + event.snapshot.value);

          HelperMethod.disableupdateDoctorTransactionSample();
          TimeLineExamineScreen.transactionID = transactionID;
          Get.off(
            TimeLineExamineScreen(),
          );
        },
      );

      isLoading = false;
    }
  }
}
