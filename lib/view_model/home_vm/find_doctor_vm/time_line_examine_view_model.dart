import 'package:drFamily_app/global_variable.dart';
import 'package:drFamily_app/screens/checkout_screen.dart';
import 'package:drFamily_app/screens/home/find_doctor/time_line_examine_page.dart';
import 'package:drFamily_app/screens/share/base_model.dart';
import 'package:drFamily_app/screens/transaction/transaction_base_screen.dart';
import 'package:drFamily_app/view_model/home_vm/find_doctor_vm/waiting_booking_doctor_view_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class TimeLineExamineViewModel extends BaseModel {
  int _currentStep = 1;

  Color colorDone = Color(0xFF27AA69);
  Color colorInprocess = Color(0xFF2B619C);
  Color colorNotYet = Color(0xFFDADADA);

  Color firstStep;
  Color firstStepBeforeLine;
  String firstStepSubText;
  bool firstStatus;

  Color secondStep;
  Color secondStepBeforeLine;
  Color secondStepAfterLine;
  String secondStepSubText;
  bool secondStatus;

  Color thirdStep;
  Color thirdStepBeforeLine;
  Color thirdStepAfterLine;
  String thirdStepSubText;
  bool thirdStatus;

  Color fourthStep;
  Color fourthStepBeforeLine;
  String fourthStepSubText;
  bool fourthStatus;

  int get currentStep => _currentStep;

  String _transactionId;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  DatabaseReference _transactionRequest;

  TimeLineExamineViewModel() {
    _transactionId = TimeLineExamineScreen.transactionID;
    print('transactionId: $_transactionId');

    WaitingBookingDoctorViewModel.screenStatus = "Analysis Symptom";
    firstStep = colorInprocess;
    firstStepBeforeLine = colorInprocess;
    firstStepSubText = "Doctor is analyzing.";
    firstStatus = false;

    secondStep = colorNotYet;
    secondStepBeforeLine = colorNotYet;
    secondStepAfterLine = colorNotYet;
    secondStepSubText = "Waiting for doctor.";
    secondStepAfterLine = colorNotYet;
    secondStatus = true;

    thirdStep = colorNotYet;
    thirdStepBeforeLine = colorNotYet;
    thirdStepAfterLine = colorNotYet;
    thirdStepSubText = "Waiting for doctor.";
    thirdStatus = true;

    fourthStep = colorNotYet;
    fourthStepBeforeLine = colorNotYet;
    fourthStepSubText = "Waiting for doctor.";
    fourthStatus = true;
    initTimeLine();

    listenStatusTransaction();
  }

  void initTimeLine() async {
    _transactionRequest =
        FirebaseDatabase.instance.reference().child("Transaction");

    await _transactionRequest.child(_transactionId).once().then(
      (DataSnapshot dataSnapshot) {
        print("init transaction");
        print(dataSnapshot.value);
        if (dataSnapshot.value == null) {
          return;
        } else {
          Map<dynamic, dynamic> values = dataSnapshot.value;
          String transactionStatus = values['transaction_status'];
          switch (transactionStatus) {
            case "Analysis Symptom":
              break;
            case "Take Sample":
              {
                firstStep = colorDone;
                firstStepBeforeLine = colorDone;
                firstStepSubText = "Doctor has done Analysis.";
                firstStatus = false;

                secondStep = colorInprocess;
                secondStepBeforeLine = colorDone;
                secondStepAfterLine = colorInprocess;
                secondStepSubText = "Doctor is taking sample.";
                secondStatus = false;
                notifyListeners();
              }
              break;
            case "Diagnose":
              {
                firstStep = colorDone;
                firstStepBeforeLine = colorDone;
                firstStepSubText = "Doctor has done Analysis.";
                firstStatus = false;

                secondStep = colorDone;
                secondStepBeforeLine = colorDone;

                secondStepAfterLine = colorDone;
                secondStepSubText = "Your sample has been taken.";
                secondStatus = false;

                thirdStep = colorInprocess;
                thirdStepBeforeLine = colorDone;
                thirdStepAfterLine = colorInprocess;
                thirdStepSubText = "Doctor is diagnosing.";
                notifyListeners();
              }
              break;
            case "Prescription":
              {
                firstStep = colorDone;
                firstStepBeforeLine = colorDone;
                firstStepSubText = "Doctor has done Analysis.";
                firstStatus = false;

                secondStep = colorDone;
                secondStepBeforeLine = colorDone;

                secondStepAfterLine = colorDone;
                secondStepSubText = "Your sample has been taken.";
                secondStatus = false;

                thirdStep = colorDone;
                thirdStepBeforeLine = colorDone;
                thirdStepAfterLine = colorDone;
                thirdStepSubText = "Doctor has done diagnosis.";
                thirdStatus = false;

                fourthStep = colorInprocess;

                fourthStepBeforeLine = colorDone;
                fourthStepSubText = "Doctor is preparing prescription.";
                fourthStatus = false;
                notifyListeners();
              }
              break;
            default:
          }
        }
        return;
      },
    );
  }

  void listenStatusTransaction() {
    transactionStatusUpdate = _transactionRequest
        .child(_transactionId)
        .onChildChanged
        .listen((event) async {
      print("change");
      print("event value: " + event.snapshot.value);
      var transactionStatus = event.snapshot.value;
      switch (transactionStatus) {
        case "Take Sample":
          {
            firstStep = colorDone;
            firstStepBeforeLine = colorDone;
            firstStepSubText = "Doctor has done Analysis.";
            firstStatus = false;

            secondStep = colorInprocess;
            secondStepBeforeLine = colorDone;
            secondStepAfterLine = colorInprocess;
            secondStepSubText = "Doctor is taking sample.";
            secondStatus = false;
            notifyListeners();
          }
          break;
        case "Diagnose":
          secondStep = colorDone;
          secondStepAfterLine = colorDone;
          secondStepSubText = "Your sample has been taken.";
          secondStatus = false;

          thirdStep = colorInprocess;
          thirdStepBeforeLine = colorDone;
          thirdStepAfterLine = colorInprocess;
          thirdStepSubText = "Doctor is diagnosing.";
          thirdStatus = false;
          notifyListeners();

          break;
        case "Prescription":
          {
            thirdStep = colorDone;
            thirdStepBeforeLine = colorDone;
            thirdStepAfterLine = colorDone;
            thirdStepSubText = "Doctor has done diagnosis.";
            thirdStatus = false;

            fourthStep = colorInprocess;
            fourthStepBeforeLine = colorDone;
            fourthStepSubText = "Doctor is preparing prescription.";
            fourthStatus = false;
            notifyListeners();
          }
          break;
        case "done":
          {
            fourthStep = colorDone;
            fourthStepBeforeLine = colorDone;
            fourthStepSubText = "Your prescription is ready for pickup.";
            fourthStatus = false;
            notifyListeners();
            Fluttertoast.showToast(
              msg: "Your have done this transaction",
              textColor: Colors.white,
              toastLength: Toast.LENGTH_SHORT,
              backgroundColor: Colors.green,
              gravity: ToastGravity.CENTER,
            );
            Get.off(
              CheckOutScreen(
                transactionId: _transactionId,
              ),
            );
          }
          break;
        case "cancel":
          {
            var result = await Get.dialog(
              Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      Icon(
                        Icons.info,
                        color: Color(0xff4ee1c7),
                        size: 90,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        "Doctor Has Cacel!",
                        style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'avenir',
                          color: Color(0xff0d47a1),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            customBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            onTap: () {
                              Get.back(result: true);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 50,
                              width: 120,
                              decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: Colors.blueAccent),
                              ),
                              child: Text(
                                "Oke",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'avenir',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ),
              ),
            );

            print("result $result");
            Get.off(
              TransactionBaseScreen(
                transactionId: _transactionId,
              ),
            );
          }

          break;
        default:
      }
      notifyListeners();
    });
  }

  void continueStep() {
    _currentStep = _currentStep + 1;
    print(_currentStep);
    if (currentStep == 2) {
      firstStep = colorDone;
      firstStepBeforeLine = colorDone;
      firstStepSubText = "Doctor has done Analysis.";
      firstStatus = false;

      secondStep = colorInprocess;
      secondStepBeforeLine = colorDone;
      secondStepAfterLine = colorInprocess;
      secondStepSubText = "Doctor is taking sample.";
      secondStatus = false;
    } else if (currentStep == 3) {
      secondStep = colorDone;
      secondStepAfterLine = colorDone;
      secondStepSubText = "Your sample has been taken.";
      secondStatus = false;

      thirdStep = colorInprocess;
      thirdStepBeforeLine = colorDone;
      thirdStepAfterLine = colorInprocess;
      thirdStepSubText = "Doctor is diagnosing.";
      thirdStatus = false;
    } else if (_currentStep == 4) {
      thirdStep = colorDone;
      thirdStepBeforeLine = colorDone;
      thirdStepAfterLine = colorDone;
      thirdStepSubText = "Doctor has done diagnosis.";
      thirdStatus = false;

      fourthStep = colorInprocess;
      fourthStepBeforeLine = colorDone;
      fourthStepSubText = "Doctor is preparing prescription.";
      fourthStatus = false;
    } else {
      fourthStep = colorDone;
      fourthStepSubText = "Your prescription is ready for pickup.";
      fourthStatus = false;
    }

    notifyListeners();
  }
}
