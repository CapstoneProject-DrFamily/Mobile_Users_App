import 'package:drFamily_app/view_model/home_vm/time_line_appoinment/base_time_line_appoiment_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

Container timeLineProcessAppoinment(BuildContext contextTimeLine,
    int processIndex, BaseTimeLineAppoinmentViewModel model) {
  return Container(
    height: 50,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: model.step.length,
      itemBuilder: (contextTimeLine, index) {
        return InkWell(
          onTap: () {
            if (model.oldStep.isNotEmpty) {
              int currentStep = model.oldStep[model.oldStep.length - 1];
              print(index);
              print(currentStep);
              (currentStep >= index)
                  ? model.backStep(index)
                  : print("notThing");
            }
          },
          child: TimelineTile(
            axis: TimelineAxis.horizontal,
            alignment: TimelineAlign.center,
            isFirst: index == 0,
            isLast: index == model.step.length - 1,
            indicatorStyle: IndicatorStyle(
              drawGap: true,
              width: (processIndex == index) ? 40 : 30,
              height: (processIndex == index) ? 40 : 30,
              indicator: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (processIndex == index ||
                              model.oldStep.contains(index))
                          ? Color(0xff0d47a1).withOpacity(0.7)
                          : Color(0xff0d47a1).withOpacity(0.1),
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 30,
                        width: 30,
                        child: Icon(
                          model.step[index],
                          size: (processIndex == index) ? 25 : 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}
