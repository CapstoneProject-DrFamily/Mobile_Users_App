import 'package:drFamily_app/screens/share/base_view.dart';
import 'package:drFamily_app/view_model/prescription_view_model.dart';
import 'package:drFamily_app/widgets/common/app_image.dart';
import 'package:flutter/material.dart';

class PrescrptionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<PrescriptionViewModel>(
      builder: (context, child, model) {
        return Scaffold(
          backgroundColor: Colors.grey.shade300,
          appBar: new AppBar(
            backgroundColor: Colors.grey.shade300,
            elevation: 0,
            title: Text(
              "Presciption",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: Container(
            height: double.infinity,
            color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Container(
                    child: Image.asset(
                      PRESCRIPTION,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 40),
                            child: Text(
                              'Medicines for ',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SingleChildScrollView(
                        child: Container(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: model.list.length,
                            itemBuilder: (context, index) => Column(
                              children: <Widget>[
                                Container(
                                  decoration: new BoxDecoration(
                                    color: index % 2 == 0
                                        ? Colors.white
                                        : Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ListTile(
                                    title: Text(model.list[index].name),
                                    subtitle: Text(
                                      ("Ngày uống: " +
                                          model.list[index].unitPerDay
                                              .toString() +
                                          ", mỗi lần: " +
                                          model.list[index].unitPerTimes
                                              .toString() +
                                          "viên / Số ngày: " +
                                          model.list[index].day.toString() +
                                          "\n Sáng: 3 viên, Trưa: 1 viên, Chiều: 2 viên"),
                                    ),
                                    leading: SizedBox(
                                      height: 40,
                                      width: 40,
                                      child: Image.asset(
                                        index % 2 == 0
                                            ? MEDICINES_ICON1
                                            : MEDICINES_ICON2,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Text(
                                "Note: ",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
