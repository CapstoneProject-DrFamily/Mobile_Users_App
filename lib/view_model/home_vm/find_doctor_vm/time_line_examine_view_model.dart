import 'package:drFamily_app/Helper/pushnotifycation_service.dart';
import 'package:drFamily_app/screens/share/base_model.dart';
import 'package:flutter/material.dart';

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

  TimeLineExamineViewModel() {
    PushNotifycationService.usStatus = "Analysis Symptom";
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
