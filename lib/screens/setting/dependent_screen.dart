import 'package:commons/commons.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:drFamily_app/screens/share/base_view.dart';
import 'package:drFamily_app/view_model/setting_vm/dependent_view_model.dart';
import 'package:drFamily_app/widgets/common/app_image.dart';
import 'package:drFamily_app/widgets/common/fonts.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DependentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Dependents",
          style: TextStyle(
            color: Colors.blue.shade300,
            fontFamily: AVENIR,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Colors.blue.shade300),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BaseView<DependentViewModel>(
        builder: (context, child, model) {
          return model.isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ),
                )
              : (model.listDependent.length != 0)
                  ? Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            model.addDependent(context);
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 15.0),
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.height / 14,
                            decoration: new BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Add dependent",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: ListView.builder(
                              itemCount: model.listDependent.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {},
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 15.0),
                                    child: Material(
                                      borderRadius: BorderRadius.circular(20.0),
                                      elevation: 6.0,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 20.0,
                                          vertical: 20.0,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: CircleAvatar(
                                                radius: 40,
                                                backgroundColor: Colors.white,
                                                backgroundImage: model
                                                            .listDependent[
                                                                index]
                                                            .dependentImage ==
                                                        null
                                                    ? NetworkImage(DEFAULT_IMG)
                                                    : NetworkImage(model
                                                        .listDependent[index]
                                                        .dependentImage),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 30.0,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  model.listDependent[index]
                                                      .dependentName,
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10.0,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Relationship:",
                                                      style: TextStyle(
                                                          fontFamily: AVENIR,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      width: 5.0,
                                                    ),
                                                    Text(
                                                      model.listDependent[index]
                                                          .dependentRelationShip,
                                                      style: TextStyle(
                                                        fontFamily: AVENIR,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10.0,
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    GestureDetector(
                                                      onTap: () async {
                                                        final SharedPreferences
                                                            prefs =
                                                            await SharedPreferences
                                                                .getInstance();
                                                        prefs.setInt(
                                                            "dependentProfileID",
                                                            model
                                                                .listDependent[
                                                                    index]
                                                                .profileID);
                                                        model
                                                            .seeDetail(context);
                                                      },
                                                      child: Container(
                                                        width: 120,
                                                        // MediaQuery.of(
                                                        //             context)
                                                        //         .size
                                                        //         .width *
                                                        //     0.3,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.08,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          16)),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.3),
                                                              spreadRadius: 1,
                                                              blurRadius: 7,
                                                              offset: Offset(0,
                                                                  3), // changes position of shadow
                                                            ),
                                                          ],
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            'See Profile',
                                                            style: GoogleFonts
                                                                .varelaRound(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color:
                                                                  Colors.blue,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10.0,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () async {
                                                        final SharedPreferences
                                                            prefs =
                                                            await SharedPreferences
                                                                .getInstance();
                                                        prefs.setInt(
                                                            "dependentProfileID",
                                                            model
                                                                .listDependent[
                                                                    index]
                                                                .profileID);
                                                        model.seeHealthRecord(
                                                            context);
                                                      },
                                                      child: Container(
                                                        width: 120,
                                                        // MediaQuery.of(
                                                        //             context)
                                                        //         .size
                                                        //         .width *
                                                        //     0.3,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.08,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          16)),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.3),
                                                              spreadRadius: 1,
                                                              blurRadius: 7,
                                                              offset: Offset(0,
                                                                  3), // changes position of shadow
                                                            ),
                                                          ],
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            'Health Record',
                                                            style: GoogleFonts
                                                                .varelaRound(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color:
                                                                  Colors.blue,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 15.0,
                                                ),
                                                GestureDetector(
                                                  onTap: () async {
                                                    bool isDelete =
                                                        await _confirmDialog(
                                                            context);
                                                    if (isDelete) {
                                                      waitDialog(context,
                                                          message:
                                                              "Deleting your dependent...");
                                                      bool check = await model
                                                          .deleteDependent(model
                                                              .listDependent[
                                                                  index]
                                                              .patientID);
                                                      print("Check: " +
                                                          check.toString());
                                                      if (check) {
                                                        Navigator.pop(context);

                                                        await CoolAlert.show(
                                                            barrierDismissible:
                                                                false,
                                                            context: context,
                                                            type: CoolAlertType
                                                                .success,
                                                            text:
                                                                "Delete Dependent Success",
                                                            backgroundColor:
                                                                Colors.lightBlue[
                                                                    200],
                                                            onConfirmBtnTap:
                                                                () {
                                                              Navigator.pop(
                                                                  context);
                                                              Navigator.of(
                                                                      context)
                                                                  .pushReplacement(MaterialPageRoute(
                                                                      builder: (BuildContext
                                                                              context) =>
                                                                          DependentScreen()));
                                                            });
                                                      } else {
                                                        Navigator.pop(context);

                                                        await CoolAlert.show(
                                                            barrierDismissible:
                                                                false,
                                                            context: context,
                                                            type: CoolAlertType
                                                                .error,
                                                            text:
                                                                "Delete error, please try again!",
                                                            backgroundColor:
                                                                Colors.lightBlue[
                                                                    200],
                                                            onConfirmBtnTap:
                                                                () {
                                                              Navigator.pop(
                                                                  context);

                                                              Navigator.of(
                                                                      context)
                                                                  .pushReplacement(MaterialPageRoute(
                                                                      builder: (BuildContext
                                                                              context) =>
                                                                          DependentScreen()));
                                                            });
                                                      }
                                                    }
                                                  },
                                                  child: Container(
                                                    width: 250,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.08,
                                                    decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  16)),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.3),
                                                          spreadRadius: 1,
                                                          blurRadius: 7,
                                                          offset: Offset(0,
                                                              3), // changes position of shadow
                                                        ),
                                                      ],
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        'Delete dependent',
                                                        style: GoogleFonts
                                                            .varelaRound(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    )
                  : Container(
                      child: Column(
                        children: <Widget>[
                          Center(
                            child: Container(
                              height: 100,
                              width: 100,
                              margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height / 3.5,
                                bottom: 20.0,
                              ),
                              child: Image.asset(
                                DEPENDENT_ICON,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Text(
                            "You don't have any dependent",
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              model.addDependent(context);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: MediaQuery.of(context).size.height / 14,
                              decoration: new BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Add dependent",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
        },
      ),
    );
  }

  Future _confirmDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (bookingContext) {
        return Dialog(
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
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    'Are you sure want to delete your dependent?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'avenir',
                      color: Colors.black,
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
                      onTap: () {
                        Navigator.of(context).pop(true);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: MediaQuery.of(bookingContext).size.width * 0.3,
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
                        Navigator.of(context).pop(false);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: MediaQuery.of(bookingContext).size.width * 0.3,
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
                  height: 45,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
