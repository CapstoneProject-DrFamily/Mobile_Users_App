import 'package:drFamily_app/screens/share/base_view.dart';
import 'package:drFamily_app/view_model/doctor_detail_view_model.dart';
import 'package:drFamily_app/widgets/common/app_image.dart';
import 'package:flutter/material.dart';

class DoctorDetailScreen extends StatelessWidget {
  final int id;
  final String token;

  DoctorDetailScreen({Key key, @required this.id, @required this.token})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<DoctorDetailViewModel>(
      builder: (context, child, model) {
        return FutureBuilder(
          future: model.getDoctorDetail(id, token),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Scaffold(
                bottomNavigationBar: _buildSaveButtom(model),
                backgroundColor: Colors.grey.shade300,
                body: SingleChildScrollView(
                  child: Stack(
                    children: [
                      _buildBody(context, model),
                      Positioned(
                        top: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: AppBar(
                          title: Text(''), // You can add title here
                          leading: new IconButton(
                            icon: new Icon(Icons.arrow_back_ios,
                                color: Colors.white),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          backgroundColor: Colors.blue
                              .withOpacity(0), //You can make this transparent
                          elevation: 0.0, //No shadow
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
          },
        );
      },
    );
  }

  Container _buildBody(BuildContext context, DoctorDetailViewModel model) {
    return Container(
      child: Stack(
        children: <Widget>[
          SizedBox(
            height: 250,
            width: double.infinity,
            child: Image.asset(
              DR_DETAIL_BACKGROUND,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(15, 200, 15, 15),
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.only(top: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(0.5),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 95),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Center(
                                  child: Text(
                                    //Get dr name
                                    model.doctor.doctorName,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Center(
                                  child: Text(
                                    //Get dr name
                                    model.doctor.doctorSpecialty,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Text(model.doctor.doctorExperience +
                                        " Year"),
                                    Text("Experiences"),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Text("800"),
                                    Text("Reviews"),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Text("4.0"),
                                    Text("Rating"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 80,
                      height: 80,
                      margin: EdgeInsets.only(left: 15),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 0),
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.15),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(
                            model.doctor.doctorImage,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text("Doctor Information"),
                      ),
                      ListTile(
                        title: Text("Specialties"),
                        subtitle: Text(model.doctor.doctorSpecialty),
                        leading: SizedBox(
                          height: 40,
                          width: 30,
                          child: Image.asset(
                            SPECIALTIES_ICON,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text("Schools"),
                        subtitle: Text(model.doctor.doctorSchool),
                        leading: SizedBox(
                          height: 40,
                          width: 30,
                          child: Image.asset(
                            EDUCATION_ICON,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text("Degrees"),
                        subtitle: Text(model.doctor.doctorDegree),
                        leading: SizedBox(
                          height: 40,
                          width: 30,
                          child: Image.asset(
                            DEGREE_ICON,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text("Description"),
                        subtitle: Text(model.doctor.doctorDescription),
                        leading: SizedBox(
                          height: 40,
                          width: 30,
                          child: Image.asset(
                            DESCRIPTION_ICON,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector _buildSaveButtom(DoctorDetailViewModel model) {
    return GestureDetector(
      onTap: () {
        model.confirmBooking();
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.blue[400],
          ),
          child: Center(
            child: Text(
              "Confirm Booking",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
