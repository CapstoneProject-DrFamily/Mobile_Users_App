import 'package:drFamily_app/screens/home/find_doctor/time_line_examine_page.dart';
import 'package:drFamily_app/screens/share/base_view.dart';
import 'package:drFamily_app/themes/colors.dart';
import 'package:drFamily_app/view_model/doctor_detail_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DoctorDetailPage extends StatelessWidget {
  final int id;
  DoctorDetailPage({Key key, @required this.id}) : super(key: key);

  Widget build(BuildContext context) {
    return BaseView<DoctorDetailViewModel>(
      builder: (context, child, model) {
        return Scaffold(
          backgroundColor: MainColors.kMainBody,
          appBar: AppBar(
            backgroundColor: MainColors.blueBegin,
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.arrow_forward, color: MainColors.white),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TimeLineExamineScreen(),
                      ),
                    );
                  }),
            ],
            title: Text('Detail'),
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Container(
              color: MainColors.blueBegin,
              child: FutureBuilder(
                  future: model.loadDoctor(id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: Text("Error"),
                        );
                      } else
                        return Container(
                          child: Column(
                            children: <Widget>[
                              Container(child: Image.network(model.doctor.url)),
                              SizedBox(height: 50),
                              Text(
                                model.doctor.name,
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(40),
                                child: Text(
                                  model.doctor.description,
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                    } else
                      return Center(
                          child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      ));
                  }),
            ),
          ),
        );
      },
    );
  }
}
