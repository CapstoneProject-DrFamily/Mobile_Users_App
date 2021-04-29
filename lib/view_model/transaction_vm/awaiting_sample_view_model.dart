import 'package:commons/commons.dart';
import 'package:drFamily_app/Helper/helper_method.dart';
import 'package:drFamily_app/repository/doctor_repo.dart';
import 'package:drFamily_app/screens/home/find_doctor/time_line_examine_page.dart';
import 'package:drFamily_app/screens/share/base_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:drFamily_app/global_variable.dart';
import 'package:get/get.dart';

class AwaitingSampleViewModel extends BaseModel {
  DatabaseReference _transactionRequest;
  IDoctorRepo _doctorRepo = DoctorRepo();

  bool isLoading = true;

  int doctorId;

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
      await _transactionRequest.child(transactionID).once().then(
        (DataSnapshot dataSnapshot) {
          if (dataSnapshot.value == null) {
            print("ERROR FB");
          } else {
            doctorId = dataSnapshot.value['doctor_id'];
            print("doctorID $doctorId");
          }
        },
      );

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

  void callPhone() async {
    var doctorPhonenum = await _doctorRepo.getDoctorPhoneNum(doctorId);
    String newPhone = "0" + doctorPhonenum.toString().substring(2);
    print('phone $newPhone');
    await launch('tel://$newPhone');
  }
}
