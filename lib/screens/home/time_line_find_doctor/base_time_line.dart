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
              onPressed: () {
                _confirmDialog(baseTimeLineContext);
              },
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
                    'This will end your process, are you sure want to go back?',
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
                        Navigator.pop(context);
                        Navigator.pop(context);
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
