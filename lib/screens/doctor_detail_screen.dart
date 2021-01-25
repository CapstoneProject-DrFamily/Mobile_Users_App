import 'package:drFamily_app/screens/share/base_view.dart';
import 'package:drFamily_app/view_model/doctor_detail_view_model.dart';
import 'package:drFamily_app/widgets/common/app_image.dart';
import 'package:flutter/material.dart';

class DoctorDetailScreen extends StatelessWidget {
  final int id;

  DoctorDetailScreen({Key key, @required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<DoctorDetailViewModel>(
      builder: (context, child, model) {
        return Scaffold(
          backgroundColor: Colors.grey.shade300,
          body: SingleChildScrollView(
            child: _buildBody(context, model),
          ),
        );
      },
    );
  }

  Container _buildBody(BuildContext context, DoctorDetailViewModel model) {
    return Container(
      child: FutureBuilder(
          future: model.loadDoctor(id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (!snapshot.hasData) {
                return Center(
                  child: Text("Error"),
                );
              } else {
                return Stack(
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Center(
                                            child: Text(
                                              //Get dr name
                                              model.doctor.name,
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
                                              model.doctor.speciality,
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
                                              Text(
                                                  model.doctor.year.toString() +
                                                      " years"),
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
                                              Text(model.doctor.rating
                                                  .toString()),
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
                                      model.doctor.url,
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
                                  subtitle: Text(model.doctor.speciality),
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
                                  subtitle: Text(model.doctor.schoolStudy),
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
                                  subtitle: Text(model.doctor.degree),
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
                                  subtitle: Text(model.doctor.description),
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
                );
              }
            }
          }),
    );
  }
}
