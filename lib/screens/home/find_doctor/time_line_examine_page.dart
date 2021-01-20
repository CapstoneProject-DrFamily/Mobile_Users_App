import 'package:drFamily_app/screens/share/base_view.dart';
import 'package:drFamily_app/view_model/home_vm/find_doctor_vm/time_line_examine_view_model.dart';
import 'package:drFamily_app/widgets/common/app_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TimeLineExamineScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<TimeLineExamineViewModel>(
      builder: (context, child, model) {
        return Scaffold(
          backgroundColor: Color(0xffF9F9F9),
          body: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(TIME_LINE),
                  alignment: Alignment.topCenter,
                  fit: BoxFit.fitWidth,
                ),
              ),
              child: Column(
                children: [
                  //set height of box continer
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.33,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xffF9F9F9),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(50),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 30, left: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _buildMainText(),
                          _buildTimeLine(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Text _buildMainText() {
    return Text(
      'Doctor is checking',
      style: GoogleFonts.varelaRound(
        fontWeight: FontWeight.bold,
        fontSize: 32,
        color: Color(0xff6c6cff),
      ),
    );
  }

  Center _buildTimeLine() {
    return Center(
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          TimelineTile(
            alignment: TimelineAlign.manual,
            lineXY: 0.1,
            isFirst: true,
            indicatorStyle: const IndicatorStyle(
              width: 20,
              color: Color(0xFF27AA69),
              padding: EdgeInsets.all(6),
            ),
            endChild: const _RightChild(
              asset: TIME_LINE_1,
              title: 'Analysis Symptom',
              message: 'Doctor has done analysis.',
            ),
            beforeLineStyle: const LineStyle(
              color: Color(0xFF27AA69),
            ),
          ),
          TimelineTile(
            alignment: TimelineAlign.manual,
            lineXY: 0.1,
            indicatorStyle: const IndicatorStyle(
              width: 20,
              color: Color(0xFF27AA69),
              padding: EdgeInsets.all(6),
            ),
            endChild: const _RightChild(
              asset: TIME_LINE_2,
              title: 'Take Sample',
              message: 'Your sample has been taken.',
            ),
            beforeLineStyle: const LineStyle(
              color: Color(0xFF27AA69),
            ),
          ),
          TimelineTile(
            alignment: TimelineAlign.manual,
            lineXY: 0.1,
            indicatorStyle: const IndicatorStyle(
              width: 20,
              color: Color(0xFF2B619C),
              padding: EdgeInsets.all(6),
            ),
            endChild: const _RightChild(
              asset: TIME_LINE_3,
              title: 'Diagnosis Processed',
              message: 'Doctor has done diagnosis.',
            ),
            beforeLineStyle: const LineStyle(
              color: Color(0xFF27AA69),
            ),
            afterLineStyle: const LineStyle(
              color: Color(0xFFDADADA),
            ),
          ),
          TimelineTile(
            alignment: TimelineAlign.manual,
            lineXY: 0.1,
            isLast: true,
            indicatorStyle: const IndicatorStyle(
              width: 20,
              color: Color(0xFFDADADA),
              padding: EdgeInsets.all(6),
            ),
            endChild: const _RightChild(
              disabled: true,
              asset: TIME_LINE_4,
              title: 'Prescription',
              message: 'Your prescription is ready for pickup.',
            ),
            beforeLineStyle: const LineStyle(
              color: Color(0xFFDADADA),
            ),
          ),
        ],
      ),
    );
  }
}

class _RightChild extends StatelessWidget {
  const _RightChild({
    Key key,
    this.asset,
    this.title,
    this.message,
    this.disabled = false,
  }) : super(key: key);

  final String asset;
  final String title;
  final String message;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          Opacity(
            child: Image.asset(asset, height: 50),
            opacity: disabled ? 0.5 : 1,
          ),
          const SizedBox(width: 16),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  title,
                  style: GoogleFonts.yantramanav(
                    color: disabled
                        ? const Color(0xFFBABABA)
                        : const Color(0xFF636564),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  message,
                  style: GoogleFonts.yantramanav(
                    color: disabled
                        ? const Color(0xFFD5D5D5)
                        : const Color(0xFF636564),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
