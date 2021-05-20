import 'package:drFamily_app/screens/share/base_view.dart';
import 'package:drFamily_app/view_model/home_vm/time_line/reason_booking_real_time_view_model.dart';
import 'package:flutter/material.dart';

class ReasonBookingRealTimeScreen extends StatelessWidget {
  final int id;
  final String token, fbId;
  final _formKey = GlobalKey<FormState>();

  ReasonBookingRealTimeScreen(
      {@required this.fbId, @required this.id, @required this.token});

  @override
  Widget build(BuildContext context) {
    return BaseView<ReasonBookingRealTimeViewModel>(
      builder: (context, child, model) {
        return FutureBuilder(
          future: model.init(),
          builder: (context, snapshot) {
            if (model.initReason) {
              return Center(child: CircularProgressIndicator());
            } else
              return Scaffold(
                body: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                ),
                                child: Text(
                                  'Note for Doctor',
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Color(0xff0d47a1),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, right: 20, left: 20),
                                child: Text(
                                  'Please describe your symptoms, questions, or condition so our care providers may provide you with the appropriate care.',
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, right: 20, left: 20),
                                child: Form(
                                  key: _formKey,
                                  child: TextFormField(
                                    initialValue:
                                        (model.note != null) ? model.note : "",
                                    maxLines: 5,
                                    maxLength: 50,
                                    onChanged: (value) {
                                      model.note = value;
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter note for doctor';
                                      }

                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        counterText: "",
                                        hintText: 'Enter your describe here',
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12))),
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
                bottomNavigationBar: _buildContinueButtom(model, context),
              );
          },
        );
      },
    );
  }

  GestureDetector _buildContinueButtom(
      ReasonBookingRealTimeViewModel model, BuildContext context) {
    return GestureDetector(
      onTap: () async {
        //confirm
        if (_formKey.currentState.validate()) {
          _confirmBookingDialog(context, model);
        }
      },
      child:
          // model.loadingProfile
          //     ? Text('')
          //     :
          Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            gradient: LinearGradient(
              colors: [Color(0xff374ABE), Color(0xff64B6FF)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: model.isLoading
                        ? CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          )
                        : Container(
                            child: Text(
                              "Booking",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _confirmBookingDialog(
      BuildContext context, ReasonBookingRealTimeViewModel model) {
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
            height: 345,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
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
                  'Are you sure want to book?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'avenir',
                    color: Colors.black,
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
                        Navigator.pop(bookingContext);
                        model.bookingDoctor(id, token, fbId, context);
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
                          "Yes",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'avenir',
                            color: Colors.white,
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
                        width: MediaQuery.of(bookingContext).size.width * 0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.blueAccent),
                        ),
                        child: Text(
                          "No",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'avenir',
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
