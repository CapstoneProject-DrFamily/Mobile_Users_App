import 'package:drFamily_app/screens/share/base_view.dart';
import 'package:drFamily_app/view_model/home_vm/find_doctor_vm/time_line_examine_view_model.dart';
import 'package:drFamily_app/widgets/common/app_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TimeLineExamineScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<TimeLineExamineViewModel>(
      builder: (context, child, model) {
        return Scaffold(
          backgroundColor: Color(0xffF9F9F9),
          body: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(TIME_LINE),
                  alignment: Alignment.topCenter,
                  fit: BoxFit.fitWidth,
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.35,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xffF9F9F9),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(50),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 30, left: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Doctor Is Checking',
                            style: GoogleFonts.varelaRound(
                              fontWeight: FontWeight.bold,
                              fontSize: 32,
                              color: Colors.blue[900],
                            ),
                          ),
                          Stepper(
                            type: StepperType.vertical,
                            steps: [
                              Step(
                                title: Text(
                                  "Analysis symptom",
                                  style: GoogleFonts.varelaRound(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                content: Text("On process Analysis"),
                                isActive: model.currentStep >= 0,
                                state: model.currentStep >= 0
                                    ? StepState.complete
                                    : StepState.editing,
                              ),
                              Step(
                                title: Text(
                                  "Take sample",
                                  style: GoogleFonts.varelaRound(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                content: Text("On process Sample"),
                                isActive: model.currentStep >= 1,
                                state: model.currentStep >= 1
                                    ? StepState.complete
                                    : StepState.editing,
                              ),
                              Step(
                                title: Text(
                                  "Make a diagnosis",
                                  style: GoogleFonts.varelaRound(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                content: Text("On process Dianosis"),
                                isActive: model.currentStep >= 2,
                                state: model.currentStep >= 2
                                    ? StepState.complete
                                    : StepState.editing,
                              ),
                              Step(
                                title: Text(
                                  "Prescription",
                                  style: GoogleFonts.varelaRound(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                content: Text("On Process Precription"),
                                isActive: model.currentStep >= 3,
                                state: model.currentStep >= 3
                                    ? StepState.complete
                                    : StepState.editing,
                              ),
                            ],
                            currentStep: model.currentStep,
                            onStepTapped: (int step) => print(step),
                            onStepContinue: model.currentStep < 3
                                ? () => model.continueStep()
                                : null,
                            onStepCancel: model.currentStep > 0
                                ? () => model.backStep()
                                : null,
                            controlsBuilder: (context,
                                    {onStepCancel, onStepContinue}) =>
                                Container(
                              height: 70,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  model.currentStep == 0
                                      ? Text('')
                                      : RaisedButton(
                                          onPressed: onStepCancel,
                                          textColor: Colors.grey,
                                          textTheme: ButtonTextTheme.normal,
                                          child: Row(
                                            children: [
                                              Icon(Icons.arrow_back_ios),
                                              Text('PREV')
                                            ],
                                          ),
                                        ),
                                  RaisedButton(
                                    onPressed: onStepContinue,
                                    textColor: Colors.white,
                                    color: Colors.indigoAccent,
                                    textTheme: ButtonTextTheme.normal,
                                    child: Row(
                                      children: [
                                        model.currentStep >= 3
                                            ? Icon(Icons.done)
                                            : Icon(Icons.arrow_forward_ios),
                                        model.currentStep >= 3
                                            ? Text('Done')
                                            : Text('Next')
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
