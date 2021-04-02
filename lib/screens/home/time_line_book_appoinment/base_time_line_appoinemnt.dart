import 'package:drFamily_app/screens/home/time_line_book_appoinment/time_line_process_appointment.dart';
import 'package:drFamily_app/screens/share/base_view.dart';
import 'package:drFamily_app/view_model/home_vm/time_line_appoinment/base_time_line_appoiment_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseTimeLineAppoinmentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext baseTimeLineAppoinmentContext) {
    return BaseView<BaseTimeLineAppoinmentViewModel>(
      builder: (baseTimeLineAppoinmentContext, child, model) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.blue[400]),
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              model.appStepText[model.initStep],
              style: TextStyle(
                color: Color(0xff0d47a1),
              ),
            ),
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back_ios, color: Color(0xff0d47a1)),
              onPressed: () =>
                  Navigator.of(baseTimeLineAppoinmentContext).pop(),
            ),
            centerTitle: true,
          ),
          body: Container(
            color: Colors.white,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: timeLineProcessAppoinment(
                      baseTimeLineAppoinmentContext, model.initStep, model),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(child: model.buildWidget(model.initStep))
              ],
            ),
          ),
        );
      },
    );
  }
}
