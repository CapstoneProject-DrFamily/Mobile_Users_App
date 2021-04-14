import 'package:drFamily_app/screens/share/base_view.dart';
import 'package:drFamily_app/view_model/home_vm/old_doctor_vm/old_doctor_screen_view_model.dart';
import 'package:drFamily_app/widgets/common/fonts.dart';
import 'package:flutter/material.dart';

class OldDoctorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<OldDoctorScreenViewModel>(
      builder: (context, child, model) {
        return FutureBuilder(
          future: model.initOldDoctor(),
          builder: (context, snapshot) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                centerTitle: true,
                title: Text("Old Doctor",
                    style: TextStyle(
                      fontFamily: AVENIR,
                      fontSize: 20,
                      color: Color(0xff0d47a1),
                    )),
                leading: GestureDetector(
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Color(0xff0d47a1),
                  ),
                  onTap: () => Navigator.pop(context),
                ),
                elevation: 0,
              ),
              body: Container(),
            );
          },
        );
      },
    );
  }
}
