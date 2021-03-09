import 'package:drFamily_app/screens/share/base_view.dart';
import 'package:drFamily_app/view_model/home_vm/find_doctor_vm/time_line_examine_view_model.dart';
import 'package:drFamily_app/widgets/common/app_image.dart';
import 'package:drFamily_app/widgets/common/feed_back_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TimeLineExamineScreen extends StatelessWidget {
  static String transactionID;
  @override
  Widget build(BuildContext context) {
    return BaseView<TimeLineExamineViewModel>(
      builder: (context, child, model) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            elevation: 0,
            title: Text(''), // You can add title here
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
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
                          SizedBox(height: 20),
                          _buildTimeLine(context, model),
                          InkWell(
                            onTap: () {
                              print('oke');
                              model.continueStep();
                              // FeedBackDialog().showCustomDialog(context);
                            },
                            child: Container(
                              width: 100,
                              height: 50,
                              color: Colors.blue,
                              child: Center(
                                child: Text(
                                  'Next',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
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

  Center _buildTimeLine(BuildContext context, TimeLineExamineViewModel model) {
    return Center(
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          shrinkWrap: true,
          primary: false,
          children: <Widget>[
            TimelineTile(
              alignment: TimelineAlign.manual,
              lineXY: 0.1,
              isFirst: true,
              indicatorStyle: IndicatorStyle(
                width: 20,
                color: model.firstStep,
                padding: EdgeInsets.all(6),
              ),
              endChild: _RightChild(
                disabled: model.firstStatus,
                asset: TIME_LINE_1,
                title: 'Analysis Symptom',
                message: model.firstStepSubText,
              ),
              beforeLineStyle: LineStyle(
                color: model.firstStepBeforeLine,
              ),
            ),
            TimelineTile(
              alignment: TimelineAlign.manual,
              lineXY: 0.1,
              indicatorStyle: IndicatorStyle(
                width: 20,
                color: model.secondStep,
                padding: EdgeInsets.all(6),
              ),
              endChild: _RightChild(
                disabled: model.secondStatus,
                asset: TIME_LINE_2,
                title: 'Take Sample',
                message: model.secondStepSubText,
              ),
              beforeLineStyle: LineStyle(
                color: model.secondStepBeforeLine,
              ),
              afterLineStyle: LineStyle(
                color: model.secondStepAfterLine,
              ),
            ),
            TimelineTile(
              alignment: TimelineAlign.manual,
              lineXY: 0.1,
              indicatorStyle: IndicatorStyle(
                width: 20,
                color: model.thirdStep,
                padding: EdgeInsets.all(6),
              ),
              endChild: _RightChild(
                disabled: model.thirdStatus,
                asset: TIME_LINE_3,
                title: 'Diagnosis Processed',
                message: model.thirdStepSubText,
              ),
              beforeLineStyle: LineStyle(
                color: model.thirdStepBeforeLine,
              ),
              afterLineStyle: LineStyle(
                color: model.thirdStepAfterLine,
              ),
            ),
            TimelineTile(
              alignment: TimelineAlign.manual,
              lineXY: 0.1,
              isLast: true,
              indicatorStyle: IndicatorStyle(
                width: 20,
                color: model.fourthStep,
                padding: EdgeInsets.all(6),
              ),
              endChild: _RightChild(
                disabled: model.fourthStatus,
                asset: TIME_LINE_4,
                title: 'Prescription',
                message: model.fourthStepSubText,
              ),
              beforeLineStyle: LineStyle(
                color: model.fourthStepBeforeLine,
              ),
            ),
          ],
        ),
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
