import 'package:drFamily_app/screens/share/base_view.dart';
import 'package:drFamily_app/view_model/home_vm/time_line/base_time_line_view_model.dart';
import 'package:drFamily_app/view_model/home_vm/time_line/history_checking_screen_view_model.dart';
import 'package:drFamily_app/view_model/home_vm/time_line_appoinment/base_time_line_appoiment_view_model.dart';
import 'package:flutter/material.dart';

class HistoryCheckingScreen extends StatelessWidget {
  final BaseTimeLineViewModel baseTimeLineViewModel;
  final BaseTimeLineAppoinmentViewModel baseTimeLineAppoinmentViewModel;
  HistoryCheckingScreen(
      {this.baseTimeLineViewModel, this.baseTimeLineAppoinmentViewModel});
  @override
  Widget build(BuildContext context) {
    return BaseView<HistoryCheckingScreenViewModel>(
      builder: (context, child, model) {
        return FutureBuilder(
          future: model.initData(),
          builder: (context, snapshot) {
            if (model.initHistoryChecking) {
              return Center(child: CircularProgressIndicator());
            } else
              return Container();
          },
        );
      },
    );
  }
}
