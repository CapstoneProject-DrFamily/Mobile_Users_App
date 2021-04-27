import 'package:drFamily_app/Helper/common.dart';
import 'package:drFamily_app/model/patient_schedule_model/patient_schedule_model.dart';
import 'package:drFamily_app/screens/share/base_view.dart';
import 'package:drFamily_app/view_model/home_vm/pop_up_choose_patient_view_model.dart';
import 'package:drFamily_app/view_model/schedule_vm/list_schedule_appointment_view_model.dart';
import 'package:drFamily_app/widgets/common/app_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ListScheduleAppointmentScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BaseView<ListScheduleAppointmentViewModel>(
      builder: (context, child, model) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            title: Text(
              'List Schedule',
              textAlign: TextAlign.center,
              style: GoogleFonts.varelaRound(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: Color(0xff0d47a1),
              ),
            ),
            actions: [
              IconButton(
                  icon: Icon(EvaIcons.flip2Outline, color: Colors.black87),
                  onPressed: () {
                    buildChoosePatient(context, model);
                  }),
            ],
          ),
          body: model.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : FutureBuilder(
                  future: model.fetchData(),
                  builder: (context, snapshot) {
                    if (model.init) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else
                      return (model.list.isEmpty)
                          ? Container(
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    NOT_FOUND_RECORDS,
                                    width: 80,
                                    height: 80,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "You don't have any appointment",
                                    style: GoogleFonts.varelaRound(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14,
                                        color: Color(0xff0d47a1),
                                        fontStyle: FontStyle.italic),
                                  ),
                                ],
                              ),
                            )
                          : Column(
                              children: [
                                buildNextSchedule(model, context),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'List upcoming appointment',
                                        style: TextStyle(
                                            color: Color(0xff0d47a1),
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: model.schedules.length,
                                    itemBuilder: (context, index) {
                                      String key =
                                          model.schedules.keys.elementAt(index);
                                      return Container(
                                        padding: EdgeInsets.only(
                                            top: 20,
                                            left: 20,
                                            right: 20,
                                            bottom: 0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.3),
                                                spreadRadius: 3,
                                                blurRadius: 4,
                                                offset: Offset(0,
                                                    3), // changes position of shadow
                                              ),
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.white,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: ExpandablePanel(
                                              header: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Text(
                                                  Common.convertSchedule(key),
                                                  style: TextStyle(
                                                    color: Color(0xff0d47a1),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              expanded: Container(
                                                // padding: EdgeInsets.only(
                                                //     top: 5,
                                                //     left: 20,
                                                //     right: 20,
                                                //     bottom: 30),
                                                child: Container(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      ListView.builder(
                                                          shrinkWrap: true,
                                                          physics:
                                                              ClampingScrollPhysics(),
                                                          itemCount: model
                                                              .schedules[key]
                                                              .length,
                                                          itemBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int index) {
                                                            return Container(
                                                              child: Column(
                                                                children: [
                                                                  InkWell(
                                                                    onTap: () {
                                                                      Alert(
                                                                        context:
                                                                            context,
                                                                        title:
                                                                            "Booking information",
                                                                        style: AlertStyle(
                                                                            isCloseButton:
                                                                                false,
                                                                            isButtonVisible:
                                                                                false,
                                                                            titleStyle:
                                                                                TextStyle(color: Color(0xff0d47a1), fontWeight: FontWeight.bold)),
                                                                        content: buildInformation(
                                                                            model.schedules[key][index],
                                                                            context,
                                                                            model),
                                                                      ).show();
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(12),
                                                                        color: Color(0xffe6eafb)
                                                                            .withOpacity(0.8),
                                                                      ),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          SizedBox(
                                                                            width:
                                                                                10,
                                                                          ),
                                                                          Text(
                                                                            Common.convertTime(model.schedules[key][index].schedule.appointmentTime),
                                                                            style:
                                                                                TextStyle(color: Color(0xff0d47a1), fontWeight: FontWeight.bold),
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                ListTile(
                                                                                  leading: CircleAvatar(
                                                                                    backgroundImage: NetworkImage(model.schedules[key][index].profile.image),
                                                                                    radius: 30,
                                                                                    backgroundColor: Colors.white,
                                                                                  ),
                                                                                  title: Text(
                                                                                    model.schedules[key][index].profile.fullName,
                                                                                    style: TextStyle(color: Color(0xff0d47a1), fontWeight: FontWeight.bold),
                                                                                  ),
                                                                                  subtitle: Text(
                                                                                    model.schedules[key][index].specialty.name,
                                                                                    style: TextStyle(color: Color(0xff0d47a1), fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                            //     Text(
                                                                            //   'sa',
                                                                            //   style: TextStyle(
                                                                            //     color: Color(
                                                                            //         0xff0d47a1),
                                                                            //   ),
                                                                            // )
                                                                          ),
                                                                          Icon(
                                                                              Icons.info,
                                                                              color: Color(0xff0d47a1)),
                                                                          SizedBox(
                                                                            width:
                                                                                10,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 10,
                                                                  )
                                                                  // index !=
                                                                  //         (model.schedules[key]
                                                                  //                 .length -
                                                                  //             1)
                                                                  //     ? Divider(
                                                                  //         thickness: 2,
                                                                  //         endIndent: 50,
                                                                  //         indent: 50,
                                                                  //       )
                                                                  //     : Container(),
                                                                ],
                                                              ),
                                                            );
                                                          }),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              tapHeaderToExpand: true,
                                              hasIcon: true,
                                              iconColor: Colors.black,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),

                                // Flexible(
                                //   child: ListView.builder(
                                //     itemCount: 100,
                                //     itemBuilder: (context, index) {
                                //       return Text('sa');
                                //     },
                                //   ),
                                // ),
                              ],
                            );
                  },
                ),
        );
      },
    );
  }

  Future buildChoosePatient(
      BuildContext context, ListScheduleAppointmentViewModel model) {
    return showDialog(
      context: context,
      builder: (dialogContex) => BaseView<PopUpChoosePatientViewModel>(
        builder: (dialogContex, child, popUpPatientModel) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))),
            title: Center(
              child: new Text(
                "Choose Person",
                style: GoogleFonts.varelaRound(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Color(0xff0d47a1),
                ),
              ),
            ),
            content: new Container(
              height: 300.0, // Change as per your requirement
              width: 300.0, // Change as per your requirement
              child: popUpPatientModel.isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            itemCount: popUpPatientModel.listDependent.length,
                            itemBuilder: (dialogContex, index) => Row(
                              children: [
                                Expanded(
                                  child: popUpPatientModel.listDependent[index]
                                              .dependentRelationShip ==
                                          "Owner"
                                      ? Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                          ),
                                          child: InkWell(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                            onTap: () {
                                              popUpPatientModel.choosePatient(
                                                  index,
                                                  popUpPatientModel
                                                      .listDependent[index]);
                                            },
                                            child: Container(
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 3,
                                                    child: ListTile(
                                                      leading: CircleAvatar(
                                                        backgroundImage: popUpPatientModel
                                                                    .listDependent[
                                                                        index]
                                                                    .dependentImage ==
                                                                null
                                                            ? NetworkImage(
                                                                DEFAULT_IMG)
                                                            : NetworkImage(
                                                                popUpPatientModel
                                                                    .listDependent[
                                                                        index]
                                                                    .dependentImage),
                                                      ),
                                                      title: Text(
                                                          popUpPatientModel
                                                              .listDependent[
                                                                  index]
                                                              .dependentName),
                                                      subtitle: Row(
                                                        children: [
                                                          Text(
                                                            popUpPatientModel
                                                                .listDependent[
                                                                    index]
                                                                .dependentRelationShip,
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Color(
                                                                  0xff0d47a1),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 7.0,
                                                          ),
                                                          Icon(
                                                            EvaIcons
                                                                .awardOutline,
                                                            color: Color(
                                                                0xff0d47a1),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  index ==
                                                          popUpPatientModel
                                                              .patientChoose
                                                      ? Expanded(
                                                          child: Icon(
                                                            EvaIcons
                                                                .radioButtonOn,
                                                            color: Color(
                                                                0xff0d47a1),
                                                          ),
                                                        )
                                                      : Expanded(
                                                          child: Icon(
                                                            EvaIcons
                                                                .radioButtonOffOutline,
                                                          ),
                                                        ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      : Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                          ),
                                          child: InkWell(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                            onTap: () {
                                              popUpPatientModel.choosePatient(
                                                  index,
                                                  popUpPatientModel
                                                      .listDependent[index]);
                                            },
                                            child: Container(
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 3,
                                                    child: ListTile(
                                                      leading: CircleAvatar(
                                                        backgroundImage: popUpPatientModel
                                                                    .listDependent[
                                                                        index]
                                                                    .dependentImage ==
                                                                null
                                                            ? NetworkImage(
                                                                DEFAULT_IMG)
                                                            : NetworkImage(
                                                                popUpPatientModel
                                                                    .listDependent[
                                                                        index]
                                                                    .dependentImage),
                                                      ),
                                                      title: Text(
                                                          popUpPatientModel
                                                              .listDependent[
                                                                  index]
                                                              .dependentName),
                                                      subtitle: Text(
                                                          popUpPatientModel
                                                              .listDependent[
                                                                  index]
                                                              .dependentRelationShip),
                                                    ),
                                                  ),
                                                  index ==
                                                          popUpPatientModel
                                                              .patientChoose
                                                      ? Expanded(
                                                          child: Icon(
                                                            EvaIcons
                                                                .radioButtonOn,
                                                            color: Color(
                                                                0xff0d47a1),
                                                          ),
                                                        )
                                                      : Expanded(
                                                          child: Icon(
                                                            EvaIcons
                                                                .radioButtonOffOutline,
                                                          ),
                                                        ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
            ),
            actions: popUpPatientModel.isLoading
                ? <Widget>[
                    Container(),
                  ]
                : <Widget>[
                    TextButton(
                      child: Text(
                        'Confirm',
                        style: GoogleFonts.varelaRound(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Color(0xff0d47a1),
                        ),
                      ),
                      onPressed: () async {
                        model.changePatients(
                            dialogContex,
                            popUpPatientModel.tempPatientChoose.patientID,
                            popUpPatientModel.tempPatientChoose.dependentName);
                      },
                    ),
                    TextButton(
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.varelaRound(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Color(0xff0d47a1),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
          );
        },
      ),
    );
  }

  Column buildInformation(PatientScheduleModel patientModel,
      BuildContext context, ListScheduleAppointmentViewModel pageModel) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        CircleAvatar(
          backgroundImage: NetworkImage(patientModel.profile.image),
          radius: 60,
          backgroundColor: Colors.white,
        ),
        ListTile(
          title: Text(
            patientModel.profile.fullName,
            style: TextStyle(
                color: Color(0xff0d47a1), fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            patientModel.specialty.name,
            style: TextStyle(
                color: Color(0xff0d47a1),
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic),
          ),
        ),
        Row(
          children: [
            Icon(
              Icons.calendar_today,
              color: Color(0xff0d47a1),
            ),
            SizedBox(
              width: 10,
            ),
            Flexible(
                child: Text(
              Common.convertSchedule(patientModel.schedule.appointmentTime),
              style: TextStyle(
                fontSize: 15,
                color: Color(0xff0d47a1),
              ),
            ))
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Icon(
              Icons.schedule,
              color: Color(0xff0d47a1),
            ),
            SizedBox(
              width: 10,
            ),
            Flexible(
                child: Text(
              Common.convertTime(patientModel.schedule.appointmentTime),
              style: TextStyle(
                fontSize: 15,
                color: Color(0xff0d47a1),
              ),
            ))
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Icon(
              Icons.location_on,
              color: Color(0xff0d47a1),
            ),
            SizedBox(
              width: 10,
            ),
            Flexible(
                child: Text(
              Common.getLocationName(patientModel.transaction.location),
              style: TextStyle(
                fontSize: 15,
                color: Color(0xff0d47a1),
              ),
            ))
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Icon(
              Icons.local_hospital,
              color: Color(0xff0d47a1),
            ),
            SizedBox(
              width: 10,
            ),
            Flexible(
                child: Text(
              patientModel.service.serviceName,
              style: TextStyle(
                fontSize: 15,
                color: Color(0xff0d47a1),
              ),
            ))
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Icon(
              Icons.attach_money,
              color: Color(0xff0d47a1),
            ),
            SizedBox(
              width: 10,
            ),
            Flexible(
                child: Text(
              Common.convertPrice(patientModel.service.servicePrice),
              style: TextStyle(
                fontSize: 15,
                color: Color(0xff0d47a1),
              ),
            ))
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: Text("Cancel appointment",
                  style: TextStyle(fontSize: 14, color: Colors.white)),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  padding:
                      MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(10)),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.red)))),
              onPressed: () async {
                await _confirmCancelBookingDialog(
                  context,
                  pageModel,
                  patientModel.schedule.scheduleId,
                  patientModel.schedule.appointmentTime,
                  patientModel.transaction.location,
                  patientModel.transaction.note,
                  patientModel.doctor.doctorId,
                  patientModel.transaction.transactionId,
                );
              },
            ),
          ],
        )
      ],
    );
  }

  Column buildNextSchedule(
      ListScheduleAppointmentViewModel model, BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Your next appointment',
                style: TextStyle(
                    color: Color(0xff0d47a1),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        model.list.length != 0 && model.list.length != null
            ? Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    Common.convertSchedule(
                        model.list[0].schedule.appointmentTime),
                    style: TextStyle(
                      color: Color(0xff0d47a1),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              )
            : Container(),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Container(
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Alert(
                      context: context,
                      title: "Booking information",
                      style: AlertStyle(
                          isCloseButton: false,
                          isButtonVisible: false,
                          titleStyle: TextStyle(
                              color: Color(0xff0d47a1),
                              fontWeight: FontWeight.bold)),
                      content: buildInformation(model.list[0], context, model),
                    ).show();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Color(0xffe6eafb).withOpacity(0.8),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          Common.convertTime(
                              model.list[0].schedule.appointmentTime),
                          style: TextStyle(
                              color: Color(0xff0d47a1),
                              fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(model.list[0].profile.image),
                                  radius: 30,
                                  backgroundColor: Colors.white,
                                ),
                                title: Text(
                                  model.list[0].profile.fullName,
                                  style: TextStyle(
                                      color: Color(0xff0d47a1),
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  model.list[0].specialty.name,
                                  style: TextStyle(
                                      color: Color(0xff0d47a1),
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic),
                                ),
                              )
                            ],
                          ),
                        ),
                        Icon(Icons.info, color: Color(0xff0d47a1)),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                )
                // index !=
                //         (model.schedules[key]
                //                 .length -
                //             1)
                //     ? Divider(
                //         thickness: 2,
                //         endIndent: 50,
                //         indent: 50,
                //       )
                //     : Container(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future _confirmCancelBookingDialog(
    BuildContext context,
    ListScheduleAppointmentViewModel model,
    scheduleId,
    time,
    location,
    note,
    doctorId,
    transactionId,
  ) {
    return showDialog(
      context: context,
      builder: (bookingContext) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
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
                        "Confirmation?",
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
                      Text(
                        'Are you sure you want to cancel this appointment?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'avenir',
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                            maxLines: 5,
                            maxLength: 255,
                            onChanged: (value) {
                              model.reasonCancel = value;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your reason';
                              }

                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: 'Enter your reason here',
                                counterText: "",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12))),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 45,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            customBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            onTap: () async {
                              if (_formKey.currentState.validate()) {
                                Navigator.pop(bookingContext);
                                await model.cancelBooking(
                                    context,
                                    scheduleId,
                                    time,
                                    location,
                                    note,
                                    doctorId,
                                    transactionId);
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 50,
                              width: MediaQuery.of(bookingContext).size.width *
                                  0.3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: Colors.blueAccent),
                              ),
                              child: Text(
                                "Yes",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'avenir',
                                  color: Colors.blueAccent,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            customBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            onTap: () {
                              Navigator.pop(bookingContext);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 50,
                              width: MediaQuery.of(bookingContext).size.width *
                                  0.3,
                              decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: Colors.blueAccent),
                              ),
                              child: Text(
                                "No",
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
            ),
          ),
        );
      },
    );
  }
}
