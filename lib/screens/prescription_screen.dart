import 'package:drFamily_app/screens/share/base_view.dart';
import 'package:drFamily_app/view_model/precription_view_model.dart';
import 'package:flutter/material.dart';

class PrescrptionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<PrescriptionViewModel>(
      builder: (context, child, model) {
        return Scaffold(
          appBar: new AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              "Presciption",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        );
      },
    );
  }
}
