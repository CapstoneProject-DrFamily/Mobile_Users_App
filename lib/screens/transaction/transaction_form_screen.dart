import 'package:drFamily_app/screens/share/base_view.dart';
import 'package:drFamily_app/themes/colors.dart';
import 'package:drFamily_app/view_model/transaction_vm/transaction_form_view_model.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class TransactionFormScreen extends StatelessWidget {
  List<String> listCheck = List();
  final String transactionId;
  TransactionFormScreen({@required this.transactionId});
  @override
  Widget build(BuildContext context) {
    return BaseView<TransactionFormViewModel>(
      builder: (context, child, model) {
        return Scaffold(
          body: SingleChildScrollView(
              child: Container(
                  child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              buildMedicalHistoryExpand(context),
              SizedBox(
                height: 10,
              ),
              buildExaminationExpand(context, model),
              SizedBox(
                height: 10,
              ),
              buildOrganismExpand(context, model),
              SizedBox(
                height: 10,
              ),
              buildDiagnoseExpand(context),
              SizedBox(
                height: 10,
              ),
              buildExaminationExperimentExpand(context),
              SizedBox(
                height: 10,
              ),
            ],
          ))),
        );
      },
    );
  }

  Row buildExaminationExperimentExpand(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent),
            borderRadius: BorderRadius.circular(15.0),
            color: Color(0xff0d47a1),
          ),
          width: MediaQuery.of(context).size.width * 0.9,
          child: ExpandablePanel(
            header: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Examination',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            // collapsed: Text('See details'),
            expanded: Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'No data',
                style: TextStyle(color: Colors.white),
              ),
            )),
            tapHeaderToExpand: true,
            hasIcon: true,
            iconColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Row buildDiagnoseExpand(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent),
            borderRadius: BorderRadius.circular(15.0),
            color: Color(0xff0d47a1),
          ),
          width: MediaQuery.of(context).size.width * 0.9,
          child: ExpandablePanel(
            header: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Diagnose',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            // collapsed: Text('See details'),
            expanded: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Diagnose / Conclusion',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please enter your conclusion";
                              }
                              return null;
                            },
                            maxLines: 5,
                            decoration: InputDecoration.collapsed(
                                hintText: 'Enter your text'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Doctor Advice',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            maxLines: 5,
                            decoration: InputDecoration.collapsed(
                                hintText: 'Enter your text'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            tapHeaderToExpand: true,
            hasIcon: true,
            iconColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Row buildOrganismExpand(
      BuildContext context, TransactionFormViewModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent),
            borderRadius: BorderRadius.circular(15.0),
            color: Color(0xff0d47a1),
          ),
          width: MediaQuery.of(context).size.width * 0.9,
          child: ExpandablePanel(
            header: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Các cơ quan',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            // collapsed: Text('See details'),
            expanded: Column(
                children: List.generate(model.listParameter.length, (index) {
              return Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 8, right: 8, bottom: 4),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Container(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Flexible(
                            flex: 2,
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    model.listParameter[index].name,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            child: Checkbox(
                              value: listCheck
                                      .contains(model.listParameter[index].name)
                                  ? true
                                  : false,
                            ),
                          )
                        ],
                      )),
                    ),
                  ),
                  Visibility(
                    visible:
                        listCheck.contains(model.listParameter[index].name),
                    child: Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              height: MediaQuery.of(context).size.height * 0.2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'text',
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            )),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ],
              );
            })),
            tapHeaderToExpand: true,
            hasIcon: true,
            iconColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Row buildExaminationExpand(
      BuildContext context, TransactionFormViewModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent),
            borderRadius: BorderRadius.circular(15.0),
            color: Color(0xff0d47a1),
          ),
          width: MediaQuery.of(context).size.width * 0.9,
          child: ExpandablePanel(
            header: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Khám lâm sàng',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            // collapsed: Text('See details'),
            expanded: buildExamination(context, model),
            tapHeaderToExpand: true,
            hasIcon: true,
            iconColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Row buildMedicalHistoryExpand(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent),
            borderRadius: BorderRadius.circular(15.0),
            color: Color(0xff0d47a1),
          ),
          child: ExpandablePanel(
            header: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Medical History',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            // collapsed: Text('See details'),
            expanded: buildMedicalHistory(context),
            tapHeaderToExpand: true,
            hasIcon: true,
            iconColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Container buildExamination(
      BuildContext context, TransactionFormViewModel model) {
    return Container(
      // width: MediaQuery.of(context).size.width * 0.8,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  '2. Thăm khám lâm sàng',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '2.1 ',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Flexible(
                      child: Text(
                        'Dấu hiệu sinh tồn, chỉ số nhân trắc học',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              buildAnthropometricIndex("Mạch", "nhịp/phút", model, "pulseRate"),
              // buildErrorMessage(),
              buildAnthropometricIndex(
                  "Nhiệt độ", "độ C", model, "temperature"),
              buildAnthropometricIndex(
                  "Huyết áp", "...", model, "bloodPressure"),
              buildAnthropometricIndex(
                  "Nhịp thở", "...", model, "respiratoryRate"),
              buildAnthropometricIndex("Cân nặng", "kg", model, "weight"),
              buildAnthropometricIndex("Chiều cao", "cm", model, "height"),
              buildAnthropometricIndex("BMI", "...", model, "BMI"),
              buildAnthropometricIndex(
                  "Vòng bụng", "...", model, "waistCircumference"),
              Divider(
                thickness: 0.5,
              ),
              buildEyeSight(model),
              Divider(
                thickness: 0.5,
              ),
              buildBody(model),
            ],
          ),
        ),
      ),
    );
  }

  Row buildMedicalHistory(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          // width: MediaQuery.of(context).size.width * 0.9,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      '1. Medical History',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        color: Colors.white.withOpacity(0.8),
                        alignment: Alignment.topCenter,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextFormField(
                          initialValue: 'text field',
                          maxLines: 5,
                          decoration: InputDecoration.collapsed(),
                          enabled: false,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row buildAnthropometricIndex(String label, String hintText,
      TransactionFormViewModel model, String field) {
    return Row(
      children: [
        SizedBox(width: 15),
        Expanded(
            child: Text(
          label,
          style: TextStyle(fontSize: 18),
        )),
        Expanded(
          //   child: Container(
          // margin: EdgeInsets.only(right: 10, bottom: 10),
          // decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(12),
          //     border: Border.all(color: MainColors.blueBegin.withOpacity(0.6))),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: TextFormField(
                // initialValue: model.getFieldNumber(field) != null
                //     ? model.getFieldNumber(field).toString()
                //     : null,

                enabled: false,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: MainColors.blueBegin, width: 2),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red, width: 2),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red, width: 2),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  hintText: hintText,
                ),
              ),
            ),
          ),
          // )
        ),
      ],
    );
  }

  Column buildEyeSight(TransactionFormViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              Text(
                '2.2 ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Flexible(
                child: Text(
                  'Thị lực',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Không kính ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildEyeExaminationForm("Mắt trái", "0 ~ 10", model, "leftEye"),
              buildEyeExaminationForm("Mắt phải", "0 ~ 10", model, "rightEye"),
              Text(
                'Có kính',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildEyeExaminationForm(
                  "Mắt trái", "0 ~ 10", model, "leftEyeGlassed"),
              buildEyeExaminationForm(
                  "Mắt phải", "0 ~ 10", model, "rightEyeGlassed"),
            ],
          ),
        ),
      ],
    );
  }

  Row buildEyeExaminationForm(String label, String hintText,
      TransactionFormViewModel model, String field) {
    return Row(
      children: [
        SizedBox(
          width: 15,
        ),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        Expanded(
            child: Container(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 10, left: 10),
            child: TextFormField(
              // initialValue: model.getFieldNumber(field) != null
              //     ? model.getFieldNumber(field).toString()
              //     : null,
              // onChanged: (value) {
              //   model.changeFieldNumber(field, model, value);
              // },
              enabled: false,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: MainColors.blueBegin, width: 2),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red, width: 2),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red, width: 2),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                hintText: hintText,
              ),
            ),
          ),
        )),
      ],
    );
  }

  Column buildBody(TransactionFormViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              Text(
                '2.3 ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Flexible(
                child: Text(
                  'Khám lâm sàng',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Row(
            children: [
              Text(
                '2.3.1 ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Flexible(
                child: Text(
                  'Toàn thân',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Da, niêm mạc',
            style: TextStyle(fontSize: 18),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            initialValue: 'model.examinationForm.mucosa',
            enabled: false,
            maxLines: 3,
            decoration: InputDecoration(
                hintText: 'Enter text',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Khác',
            style: TextStyle(fontSize: 18),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            initialValue: 'model.examinationForm.otherBody',
            enabled: false,
            maxLines: 3,
            decoration: InputDecoration(
                hintText: 'Enter text',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12))),
          ),
        ),
      ],
    );
  }
}
