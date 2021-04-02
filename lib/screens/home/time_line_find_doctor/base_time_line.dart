import 'package:drFamily_app/screens/home/time_line_find_doctor/time_line_process.dart';
import 'package:drFamily_app/screens/share/base_view.dart';
import 'package:drFamily_app/view_model/home_vm/time_line/base_time_line_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseTimeLineScreen extends StatelessWidget {
  @override
  Widget build(BuildContext baseTimeLineContext) {
    return BaseView<BaseTimeLineViewModel>(
      builder: (baseTimeLineContext, child, model) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.blue[400]),
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              (model.initStep == 0)
                  ? (model.typeFindDoctor == 1)
                      ? model.sympton
                      : model.appStepText[model.initStep]
                  : model.appStepText[model.initStep],
              style: TextStyle(
                color: Color(0xff0d47a1),
              ),
            ),
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back_ios, color: Color(0xff0d47a1)),
              onPressed: () => Navigator.of(baseTimeLineContext).pop(),
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
                  child: timeLineProcess(
                      baseTimeLineContext, model.initStep, model),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(child: model.buildWidget(model, model.initStep))
              ],
            ),
          ),
        );
      },
    );
  }
}
